extends Area2D

func _on_area_up_area_entered(area):
	var block = area.get_parent()
	if block is Block:
		if block.type == "rock":
			GameState.dead = true
			GameState.score = "YOU ARE DEAD, SCORE: " + GameState.score
