extends VBoxContainer

onready var Lobby = $"/root/Lobby"

func _process(delta):
	for child in get_children():
		child.queue_free()
	for player_id in Lobby.player_info:
		var player = Lobby.player_info[player_id]
		var player_label = Label.new()
		player_label.text = player.name
		add_child(player_label)
