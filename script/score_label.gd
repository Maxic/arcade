extends Label

func _physics_process(delta):
	text = "Score: " + str(GameState.score)
	
	if GameState.score_visible == false:
		visible = false
