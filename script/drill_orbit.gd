extends Node2D

var drill_pos

func _physics_process(_delta):
	drill_pos = $drill_static.global_position
	look_at(get_viewport().get_mouse_position())
