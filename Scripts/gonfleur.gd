extends KinematicBody2D

var gravity = 20
var velocity = Vector2()

func _ready():
	pass
func _physics_process(delta):
	velocity.y += gravity
	move_and_slide(velocity, Vector2(0, -1))

func _je_suis_gonfleur():
	pass
