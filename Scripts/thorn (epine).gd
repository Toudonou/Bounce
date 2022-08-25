extends KinematicBody2D
signal hit

var gravity = 20
var velocity = Vector2()

func _ready():
	add_user_signal("hit")
func _physics_process(delta):
	velocity.y += gravity
	move_and_slide(velocity, Vector2(0, -1))

func _je_suis_ennemi():
	pass

func _on_Area2D_body_entered(body):
	if body.has_method("_je_suis_ball"):
		emit_signal("hit")

