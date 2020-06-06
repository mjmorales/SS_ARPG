extends KinematicBody2D

onready var Lobby = $"/root/Lobby"

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
var falling: int = 0
var pid: int
var velocity = Vector2.ZERO

func owned_by_active_player():
	return get_tree().get_network_unique_id() == pid

puppet func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("ui_up"):
			if is_on_floor():
				velocity.y = jump_speed

func sname(name: String):
	$Name.text = name

func broadcast():
	rpc_unreliable("_set_position", position)

func _ready():
#	Lobby.tick(self, "broadcast")
	pass
func _physics_process(delta):
	if owned_by_active_player():
		_local_physics_process(delta)
		broadcast()
remote func _set_position(_position):
	position = _position

func _local_physics_process(delta):
	if is_on_floor():
		falling = 0
	else:
		falling += 1
		if falling >= 300:
			position = Vector2(0,0)
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
