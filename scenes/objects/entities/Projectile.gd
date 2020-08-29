extends "res://scenes/objects/Entity.gd"

func _local_physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_ExpirationTimer_timeout():
	queue_free()
