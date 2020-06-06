extends LineEdit

onready var Lobby = $"/root/Lobby"

func _ready():
	text = Lobby.my_info.name


func _on_PlayerNameEdit_text_changed(new_text):
	Lobby.my_info.name = new_text
