extends Timer

func _on_block_speed_timer_timeout():
	GameState.block_speed += .01
