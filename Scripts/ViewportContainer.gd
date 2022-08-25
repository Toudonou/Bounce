extends ViewportContainer

onready var taille = get_viewport_rect().size

func _process(delta):
	$pause.rect_position.x = taille.x - 50
	$scoreLabel.rect_position.x = taille.x - 140 
	$Panel.rect_position.x = (taille.x - $Panel.rect_position.x) * 0.5 + 100
	$Panel.rect_position.y = (taille.y - $Panel.rect_size.y) * 0.5
	$gameOverPanel.rect_position = $Panel.rect_position
	$winPanel.rect_position.x = (taille.x - $winPanel.rect_position.x) * 0.5 + 100
	$winPanel.rect_position.y = (taille.y - $winPanel.rect_size.y) * 0.5
