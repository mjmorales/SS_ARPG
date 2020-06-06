extends Button

onready var Lobby = $"/root/Lobby"
onready var Network = $"/root/Network"

func _on_CreateServerBtn_pressed():
	Network.create_server()
	if is_network_master():
		Lobby.register_player(Lobby.my_info)
		get_tree().change_scene("res://scenes/ui/PreGameLobby.tscn")
	else:
		print("SOMETHING WENT WRONG")
