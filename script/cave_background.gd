extends Node2D

var offset = 0
var delta_sum = 0
var speed_factor = .0003

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	offset += GameState.block_speed * speed_factor
	$background_noise.material.set_shader_param("scroll_speed", offset)
