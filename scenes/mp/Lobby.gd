
extends Node

func _ready():
#	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

remote var player_info = {}
var my_info = { name = "John Doe" }

#func _player_connected(id):
#	rpc_id(id, "_register_player", my_info)

func _player_disconnected(id):
	player_info.erase(id)

func _connected_ok():
	print("CONNECTED OK")
	register_player(my_info)

func _server_disconnected():
	pass

func _connected_fail():
	print("CONNECTED FAILED")
	pass

master func _register_player(info):
	var id = get_tree().get_rpc_sender_id()
	if is_network_master():
		player_info[id] = info
		for pid in player_info:
			if pid == 1:
				continue
			rset_id(pid, "player_info", player_info)

func register_player(info):
	rpc_id(1, "_register_player", info)
	
func tick(node, conn: String):
	get_node("Tick").connect("timeout", node, conn)
