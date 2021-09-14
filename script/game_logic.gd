extends Node2D

var block_size
var block_start_height


# export variables
export var margin_horizontal = 50 # margin on a single side
export var grid_height = 100
export var grid_width = 7

var dirt_block_scene = preload("res://scenes/dirt_block.tscn")

func _ready():
	# Spawn blocks of dirt, from halfway down the screen
	block_start_height = get_viewport().size.y / 2
	block_size = (get_viewport().size.x - (margin_horizontal*2)) / grid_width
	
	for row_i in range(grid_height):
		for block_i in range(grid_width):
			var dirt_block = dirt_block_scene.instance()
			dirt_block.position.x = (block_size * block_i) + margin_horizontal
			dirt_block.position.y = (block_size * row_i) + block_start_height
			add_child(dirt_block)

