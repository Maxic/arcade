extends Area2D

var end_screen = load("res://scenes/end_screen.tscn")

func _on_area_up_area_entered(area):
	var block = area.get_parent()
	if block is Block:
		if block.type == "rock":
			
			GameState.dead = true
			var end_screen_inst = end_screen.instance()
			get_node("/root/main/").add_child(end_screen_inst)
		else:
			block.destroyed_by_laser = true
