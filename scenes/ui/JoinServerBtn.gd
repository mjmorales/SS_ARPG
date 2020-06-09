extends Button

onready var Lobby = $"/root/Lobby"
onready var Network = $"/root/Network"

func _on_JoinServerBtn_pressed():
	var server_ip_edit = get_parent().get_node("JoinServerIPEdit")
	var server_ip = "127.0.0.1"
	if server_ip_edit.text:
		server_ip = server_ip_edit.text
	Network.join_server(server_ip)
	Lobby.register_player(Lobby.my_info)
	get_tree().change_scene("res://scenes/ui/PreGameLobby.tscn")
