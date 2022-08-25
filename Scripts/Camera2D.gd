extends Camera2D

func _process(delta):
	for i in get_parent().get_children():
		if i.name == "Player":
			position = i.global_position
