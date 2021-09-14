extends Node2D

var block_size
var block_start_height


# export variables
export var margin_horizontal = 50 # margin on a single side
export var grid_height = 100
export var grid_width = 7

var dirt_block_scene = preload("res://scenes/dirt_block.tscn")
var emerald_block_scene = preload("res://scenes/emerald_block.tscn")
var rock_block_scene = preload("res://scenes/rock_block.tscn")
var ruby_block_scene = preload("res://scenes/ruby_block.tscn")
var diamond_block_scene = preload("res://scenes/diamond_block.tscn")

func _ready():
	var block_arr = [dirt_block_scene, dirt_block_scene, dirt_block_scene, dirt_block_scene, dirt_block_scene, dirt_block_scene, dirt_block_scene, dirt_block_scene, dirt_block_scene, dirt_block_scene, dirt_block_scene, dirt_block_scene, emerald_block_scene, rock_block_scene, ruby_block_scene, diamond_block_scene]
	
	
	# Spawn blocks of dirt, from halfway down the screen
	block_start_height = get_viewport().size.y / 2
	block_size = (get_viewport().size.x - (margin_horizontal*2)) / grid_width
	
	for row_i in range(grid_height):
		for block_i in range(grid_width):
			block_arr.shuffle()
			var block_scene = block_arr[0]
			var block = block_scene.instance()
			block.position.x = (block_size * block_i) + margin_horizontal
			block.position.y = (block_size * row_i) + block_start_height
			add_child(block)

