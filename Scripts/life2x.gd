extends Area2D

signal lifeUp

func _ready():
	add_user_signal("lifeUp")

func _on_life2x_body_entered(body):
	if body.has_method("_je_suis_ball"):
		emit_signal("lifeUp")
		queue_free()
