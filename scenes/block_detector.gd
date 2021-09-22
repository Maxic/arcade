extends Node2D

var block_speed
var no_blocks = false

func _process(delta):
	var theres_blocks = $detection_area.get_overlapping_areas()
	if !theres_blocks:
		if !no_blocks:
			block_speed = GameState.block_speed
		no_blocks = true
		GameState.block_speed = 3
	if theres_blocks && no_blocks:
		GameState.block_speed = block_speed
		no_blocks = false
	
			
