extends "./NetworkEntity.gd"

export (int) var jump_speed = -1800
remote var direction := "right"
remote var body_parts := {
	"Head": "Base",
	"Torso": "Base",
	"Legs": "Base",
}
remote var animation_parts := {
	"Head": "Idle",
	"Torso": "Idle",
	"Legs": "Idle",
}

func _ready():
	speed = 800
	gravity = 3000

func get_input():
	velocity.x = 0
	set_body_parts("Idle")
	if Input.is_action_pressed("ui_right"):
		direction = "right"
		set_body_parts("Run")
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		direction = "left"
		set_body_parts("Run")
		velocity.x -= speed
	if Input.is_action_just_pressed("ui_up"):
			set_body_parts("Jump_Up")
			if is_on_floor():
				velocity.y = jump_speed

func _unhandled_input(event):
	if owned_by_active_player():
		if event.is_action_pressed("ui_select"):
			shoot_projectile()

func sname(name: String):
	$Name.text = name

func shoot_projectile():
	var projectile_data := {
		"pid": pid,
		"position": position,
		"velocity": Vector2(100,0),
		"gravity": 0,
	}
	if direction == "left":
		projectile_data["velocity"].x *= -1
	var packed_scene_path := "res://scenes/objects/entities/Projectile.tscn"
	EntitySpawner.spawn_entity(packed_scene_path, projectile_data, null)

func set_body_parts(animation_state):
	animation_parts["Head"] = animation_state
	animation_parts["Torso"] = animation_state
	animation_parts["Legs"] = animation_state

func _animation_for_body_part(body_part_key):
	var format_key := {
		"name": body_parts[body_part_key],
		"part": body_part_key,
		"animation": animation_parts[body_part_key]
	}
	return "{name}__{part}__{animation}".format(format_key)

func animate():
	$Animations/Head.play(_animation_for_body_part("Head"))
	$Animations/Torso.play(_animation_for_body_part("Torso"))
	$Animations/Legs.play(_animation_for_body_part("Legs"))
	var parts := [$Animations/Torso, $Animations/Head,$Animations/Legs]
	for part in parts:
		if direction == "right":
			part.flip_h = false
		else:
			part.flip_h = true

func _broadcast():
	rset("direction", direction)
	rset("animation_parts", animation_parts)
	rset("body_parts", body_parts)

func _process(delta):
	animate()
