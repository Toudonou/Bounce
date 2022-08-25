extends Node2D
const FILE_NAME = "game-data.json"
var dico = {}
var next_dictionnary = {}

var joueur = preload("res://Scènes/Player.tscn")
var score = 0000000
var score_fin 
var nombre_etoile
export (int) var vie = 3
var pause_menu = false
var nombre_anneau 
export (int) var ID_niveau
var Player
onready var checkpoint = {"pos.x" : $pos_init_player.position.x, "pos.y" : $pos_init_player.position.y}
var last_pos = []

func _ready():
	load_game()
	chargeJoueur()
	for k in $life2x.get_children():
		k.connect("lifeUp", self, "_life2x")
	for j in $ennemis.get_children():
		j.connect("hit", self, "priseVie")
	for j in $dyn_thorn.get_children():
		j.connect("hit", self, "priseVie")
	for i in $anneaux.get_children():
		i.connect("passer", self, "scoreFonction")
	nombre_anneau = $anneaux.get_child_count()

func _process(delta):
	$CanvasLayer/ViewportContainer/scoreLabel.text = str(score)
	$CanvasLayer/ViewportContainer/life_label.text = "x" + str(vie)
	$CanvasLayer/ViewportContainer/Panel/Label.text = "LEVEL : 0" + str(ID_niveau)
	$CanvasLayer/ViewportContainer/anneaux_label.text = "x" + str(nombre_anneau)
	if pause_menu: $CanvasLayer/ViewportContainer/Panel.show()
	else: $CanvasLayer/ViewportContainer/Panel.hide() 
	if vie == 0:
		$CanvasLayer/ViewportContainer/gameOverPanel.show()
		get_tree().paused = true
	$CanvasLayer/ViewportContainer/winPanel/Label.text = "  LEVEL0" + str(ID_niveau) + "\nCOMPLETE"
	$CanvasLayer/ViewportContainer/winPanel/Label2.text = str(score_fin)
	if nombre_anneau == 0:
		$StaticBody2D/AnimatedSprite.play("default")
	last_pos = [Player.position.x, Player.position.y]

func chargeJoueur():
	Player = joueur.instance()
	Player.get_node("Camera2D").limit_top = int($limit_camera.position.y * Player.get_node("Camera2D").zoom.y)
	Player.get_node("Camera2D").limit_right = int($limit_camera.position.x * Player.get_node("Camera2D").zoom.y)
	Player.connect("mort", self, "chargeJoueur")
	Player.connect("Checkpoint", self, "point")
	if vie != 0:
		Player.start(Vector2(checkpoint["pos.x"], checkpoint["pos.y"]))
	else:
		Player.get_node("Sprite").texture = preload("res://Sprites/Mobile - Bounce Original - Everything/Everything (Medium)/ball_pop@2x.png")
		Player.start(Vector2(last_pos[0], last_pos[1]))
	add_child(Player)

func point(a, b):
	checkpoint["pos.x"] = a 
	checkpoint["pos.y"] = b

func scoreFonction():
	score += 0000500
	nombre_anneau -= 1

func priseVie():
	vie -= 1

func _life2x():
	vie += 2

func _on_pause_pressed():
	pause_menu = true
	get_tree().paused = true

func _on_resume_pressed():
	if pause_menu: pause_menu = false
	else: pause_menu = true
	get_tree().paused = false

func _on_restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_retry_pressed():
	_on_restart_pressed()

func _on_AnimatedSprite_animation_finished():
	$StaticBody2D/CS.queue_free()

func _on_Area2D_body_entered(body):
	if body.has_method("_je_suis_ball"):
		score_fin = score + vie * 1000
		if vie >= 3:
			nombre_etoile = 3
		if vie == 2:
			nombre_etoile = 2
		if vie == 1:
			nombre_etoile = 1
		$CanvasLayer/ViewportContainer/winPanel.show()
		for i in range(nombre_etoile):
			for j in get_node("CanvasLayer/ViewportContainer/winPanel/Node2D").get_children():
				if j.name == "Sprite"+str(i + 1):
					j.show()
		if nombre_etoile > dico["max_etoile" + str(ID_niveau)]:
			 dico["max_etoile" + str(ID_niveau)] = nombre_etoile
		if dico["level"] == ID_niveau:
			dico["level"] += 1
		save_game()
		get_tree().paused = true

func _on_rejouer_pressed():
	_on_restart_pressed()

func _on_menu_pressed():
	get_tree().change_scene("res://Scènes/menu.tscn")

func save_game():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(dico))
	file.close()

func load_game():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			next_dictionnary = data
			dico = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")

func _on_next_pressed():
	load_game()
	if next_dictionnary["level"] >= ID_niveau:
		if ID_niveau + 1 <= 3:
			get_tree().change_scene("res://Scènes/level0"+str(ID_niveau + 1)+".tscn")
			get_tree().paused = false
		else:
			get_tree().change_scene("res://Scènes/menu.tscn")
			get_tree().paused = false
