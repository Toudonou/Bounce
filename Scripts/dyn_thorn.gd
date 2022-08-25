extends KinematicBody2D
signal hit
var speed = 50
var velocity = Vector2(0,0)
var liste = []
var dirPos = 0
export (int) var index = 0

func _ready():
	add_user_signal("hit")
	liste = [get_parent().get_node("limiteGauche" + str(index)), get_parent().get_node("limiteDroite" + str(index))]

func _physics_process(delta):
	velocity = liste[dirPos].position - position
	move_and_slide(velocity.normalized() * speed)
	
	if velocity.length_squared() < 0.3:
		dirPos = (dirPos + 1) % liste.size()


func _je_suis_ennemi():
	pass

func _on_Area2D_body_entered(body):
	if body.has_method("_je_suis_ball"):
		emit_signal("hit")

