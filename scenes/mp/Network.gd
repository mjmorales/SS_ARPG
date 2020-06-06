extends Node

var SERVER_PORT = 3001
var MAX_PLAYERS = 10
onready var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()

func create_server():
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	
func join_server(server_ip):
	peer.create_client(server_ip, SERVER_PORT)
	get_tree().network_peer = peer
