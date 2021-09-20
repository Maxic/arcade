extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready():
	$background_noise.material.set_shader_param("scroll_speed", GameState.bg_speed)
