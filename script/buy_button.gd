extends Button



func _on_buy_button_pressed():
	GameState.paused = !GameState.paused
	get_node("/root/main/ui_layer/ui/buy_screen").visible = !get_node("/root/main/ui_layer/ui/buy_screen").visible
