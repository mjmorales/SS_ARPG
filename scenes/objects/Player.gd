extends "./Entity.gd"

export (int) var jump_speed = -1800

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
