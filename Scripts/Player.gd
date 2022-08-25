extends RigidBody2D
signal mort

export (float) var speed = 12
export (float) var jump = 600
var velocity = Vector2(0, 0)
var vie = 3
var is_in_water = false

var a = 0
var b = 0
signal Checkpoint(a, b)

func _ready():
	add_user_signal("mort")
	add_user_signal("Checkpoint")
var i = Vector2(0, 0)
func _integrate_forces(state):
	$Area2D/CollisionShape2D2.scale = $CollisionShape2D.scale
	velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed
	velocity.y =  -int(Input.is_action_just_pressed("ui_accept")) * jump
	apply_central_impulse(velocity)
	
	if is_in_water == true: 
		position.y = i.y
		gravity_scale = 0
	else: 
		gravity_scale = 9.8
	


func _je_suis_ball():
	pass

func start(pos):
	position = pos

func _on_Area2D_area_entered(area):
	if area.has_method("_je_suis_checkpoint"):
		a = area.position.x
		b = area.position.y
		emit_signal("Checkpoint", a, b)
	if area.has_method("_je_suis_eau"):
		is_in_water = true
		print(position)
		print(area.position)
		i = area.get_node("Position2D").position


func _on_Area2D_body_entered(body):
	if body.has_method("_je_suis_ennemi"):
		get_tree().paused = true
		$Area2D.queue_free()
		$Sprite.texture = preload("res://Sprites/Mobile - Bounce Original - Everything/Everything (Medium)/ball_pop@2x.png")
		yield($Timer, "timeout")
		get_tree().paused = false
		emit_signal("mort")
		queue_free()
	
	if body.has_method("_je_suis_gonfleur"):
		$Sprite.scale = Vector2(0.35, 0.35)
		$CollisionShape2D.scale = Vector2(1.4, 1.4)
		
	if body.has_method("_je_suis_degonfleur"):
		$Sprite.scale = Vector2(0.25, 0.25)
		$CollisionShape2D.scale = Vector2(1, 1)



func _on_Area2D_area_exited(area):
	if area.has_method("_je_suis_eau"):
		is_in_water = false
		i = area.get_node("Position2D").global_position
