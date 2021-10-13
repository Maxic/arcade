extends Label

func _physics_process(_delta):
	text = str(GameState.score)
	
	if GameState.score_visible == false:
		visible = false
