extends Node2D

var block_size
var block_start_height
var block_speed = .5

# randomize vars
var total_weight
var block_dict = {}

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
	# Populate dict with [roll_weight, acc_weight]
	block_dict[dirt_block_scene] = 		[3.0, 0.0]
	block_dict[emerald_block_scene] = 	[0.2, 0.0]
	block_dict[diamond_block_scene] = 	[0.1, 0.0]
	block_dict[ruby_block_scene] = 		[0.2, 0.0]
	block_dict[rock_block_scene] = 		[0.3, 0.0]
	
	# initialize the dict so blocks can be picked
	init_probabilities(block_dict)
	
	# Spawn blocks of dirt, from halfway down the screen
	block_start_height = get_viewport().size.y / 2
	block_size = (get_viewport().size.x - (margin_horizontal*2)) / grid_width
	
	for row_i in range(grid_height):
		for block_i in range(grid_width):
			var block = pick_some_object(block_dict).instance()
			block.position.x = (block_size * block_i) + margin_horizontal
			block.position.y = (block_size * row_i) + block_start_height
			add_child(block)

func _physics_process(delta):
	for block in get_tree().get_nodes_in_group("blocks"):
		block.position.y -= block_speed

func init_probabilities(object_types) -> void:
	# Reset total_weight to make sure it holds the correct value after initialization
	total_weight = 0.0
	# Iterate through the objects
	for obj_type in object_types.values():
		# Take current object weight and accumulate it
		total_weight += obj_type[0]
		# Take current sum and assign to the object.
		obj_type[1] = total_weight

func pick_some_object(object_types):
	# Roll the number
	var roll: float = rand_range(0.0, total_weight)
	# Now search for the first with acc_weight > roll
	for obj_type in object_types:
		if (object_types[obj_type][1] > roll):
			return obj_type
