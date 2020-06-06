extends Button

onready var Lobby = $"/root/Lobby"
onready var Network = $"/root/Network"

func _on_JoinServerBtn_pressed():
	Network.join_server("127.0.0.1")
	Lobby.register_player(Lobby.my_info)
	get_tree().change_scene("res://scenes/ui/PreGameLobby.tscn")
