extends Node2D


var FILE_NAME = "game-data.json"
var dic = {"level":1,"max_etoile1":0,"max_etoile2":0,"max_etoile3":0,"max_etoile4":0}

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scènes/menu.tscn")

func _ready():
	save()

func _on_Button_pressed():
	$CanvasLayer/AcceptDialog.show()

func save():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		pass
	else:
		file.open(FILE_NAME, File.WRITE)
		file.store_line(to_json(dic))
	file.close()
