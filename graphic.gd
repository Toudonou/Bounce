extends KinematicBody2D

var speed = 150
var velocity = Vector2(0,0)
var liste = []
var dirPos = 0


func _ready():
	for i in get_parent().get_node("Node2D").get_children():
		liste.append(i)
	

func _physics_process(delta):
	velocity = liste[dirPos].position - position
	move_and_slide(velocity.normalized() * speed)
	
	if velocity.length_squared() < 1.5:
		dirPos = (dirPos + 1) % liste.size()


