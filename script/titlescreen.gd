extends Node

var timer = 0

func _physics_process(delta):
	timer += 1
	
	if timer % 50 == 0:
		$black_bg/TextureRect/tap_to_start_label.visible = !$black_bg/TextureRect/tap_to_start_label.visible
