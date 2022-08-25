extends Node2D

signal passer


func _ready():
	add_user_signal("passer")

func _on_Area2D_body_entered(body):
	if body.has_method("_je_suis_ball"):
		emit_signal("passer")
		$Node2D2/ring_small_top2x.queue_free()
		$Node2D/Area2D/ring_small_bottom2x.queue_free()
		$Node2D/Area2D/CollisionPolygon2D.queue_free()
