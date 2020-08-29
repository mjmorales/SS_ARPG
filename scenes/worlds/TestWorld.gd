extends Node2D

onready var Lobby = $"/root/Lobby"

func _ready():
	_spawn_players()

func _spawn_players():
	for pid in Lobby.player_info:
		var player_info = Lobby.player_info[pid]
		var player = preload("res://scenes/objects/Player.tscn").instance()
		player.set_name(str(pid))
		player.sname(player_info.name)
		player.set_network_master(pid)
		player.pid = pid
		if pid == get_tree().get_network_unique_id():
			player.position = Vector2(100, 0)
			player.get_node("Camera2D").current = true
		add_child(player)
