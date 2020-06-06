extends Button

onready var Lobby = $"/root/Lobby"

remotesync func _start_game():
	get_tree().change_scene("res://scenes/worlds/TestWorld.tscn")

func _on_StartGameBtn_pressed():
	rpc("_start_game")
