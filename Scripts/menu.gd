extends Control
const FILE_NAME = "game-data.json"
var niveau_max = 4
var dico = {}

func _process(delta):
	load_game()
	for i in range(niveau_max):
		if i in range(dico["level"]):
			get_node("CanvasLayer/Node2D").get_child(i).get_node("Sprite7").hide()
			get_node("CanvasLayer/Node2D").get_child(i).set_disabled(false)
			for j in range(dico["max_etoile" + str(i+1)]):
				get_node("CanvasLayer/Node2D").get_child(i).get_node("Sprite" + str(3+1+j)).show()
			
		else:
			get_node("CanvasLayer/Node2D").get_child(i).get_node("Sprite7").show()
			get_node("CanvasLayer/Node2D").get_child(i).set_disabled(true)
			for j in range(3):
				get_node("CanvasLayer/Node2D").get_child(i).get_node("Sprite" + str(3+1+j)).hide()



func load_game():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			dico = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")



func _on_Button1_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scènes/level01.tscn")


func _on_Button2_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scènes/level02.tscn")


func _on_Button3_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scènes/level03.tscn")


func _on_retour_pressed():
	get_tree().change_scene("res://Scènes/accueil.tscn")


func _on_reset_pressed():
	var dictionnaire = { "level": 1, "max_etoile1": 0, "max_etoile2": 0, "max_etoile3": 0, "max_etoile4": 0 }
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(dictionnaire))
	file.close()
	for j in range(3):
		get_node("CanvasLayer/Node2D").get_child(0).get_node("Sprite" + str(3+1+j)).hide()
