extends Button



func _on_buy_button_pressed():
	GameState.paused = !GameState.paused
