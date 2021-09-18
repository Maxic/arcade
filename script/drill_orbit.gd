extends Node2D

func _physics_process(_delta):
	GameState.drill_pos = $drill_static.global_position
	GameState.drill_rotation = rotation_degrees
	look_at(get_viewport().get_mouse_position())
