extends KinematicBody2D

export (int) var speed = 1200
export (int) var gravity = 4000

var falling: int = 0
var velocity = Vector2.ZERO
var stats: Dictionary = {}

func _physics_process(delta):
	if is_on_floor():
		falling = 0
	else:
		falling += 1
		if falling >= 300:
			position = Vector2(0,0)
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
