extends Area2D


func _je_suis_checkpoint():
	pass


func _on_checkpoint_body_entered(body):
	if body.has_method("_je_suis_ball"):
		$Sprite.hide()
		$Sprite2.show()
