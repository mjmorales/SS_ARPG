extends "./NetworkEntity.gd"

export (int) var jump_speed = -1800

func _ready():
	speed = 800
	gravity = 3000

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("ui_up"):
			if is_on_floor():
				velocity.y = jump_speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed

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

	var packed_scene_path := "res://scenes/objects/entities/Projectile.tscn"
	EntitySpawner.spawn_entity(packed_scene_path, projectile_data, null)
