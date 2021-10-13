extends Node2D

var block_size
var block_start_height
var block_speed
var block_arr = []

# randomize vars
var total_weight
var block_dict = {}

# export variables
export var margin_horizontal = 50 # margin on a single side
export var grid_height = 10
export var grid_width = 7

func _ready():
	# Add drill to world
	var drill = Drill.new()
	drill.name = "drill"
	add_child(drill)
	
	# Populate dict with [roll_weight, acc_weight]
	# Roll weight: The weight of the item being chosen
	# Accumulated weight: To be filled in in init_probabilities
	# Roll weight / total weight is the chance of being chosen
	block_dict["dirt"] = 	[3.0, 0.0]
	block_dict["emerald"] = [0.2, 0.0]
	block_dict["diamond"] = [0.1, 0.0]
	block_dict["ruby"] = 	[0.2, 0.0]
	#block_dict["rock"] = 	[0.5, 0.0]
	
	# initialize the dict so blocks can be picked
	init_probabilities(block_dict)
	
	# Spawn blocks of dirt, from halfway down the screen
	block_start_height = get_viewport().size.y / 2
	block_size = (get_viewport().size.x - (margin_horizontal*2)) / grid_width
	
	# Initial set of blocks
	for row_i in range(grid_height):
		for block_i in range(grid_width):
			var block = Block.new(pick_some_object(block_dict))
			block.position.x = (block_size * block_i) + margin_horizontal
			block.position.y = (block_size * row_i) + block_start_height
			block_arr.append(block)
			add_child(block)

func _physics_process(_delta):
	# Don't proceed with game when player is dead
	if GameState.dead or GameState.paused:
		return
	
	# Block movement
	for block in get_tree().get_nodes_in_group("blocks"):
		block.position.y -= GameState.block_speed
		
	# Spawn new blocks when there are less than 80 blocks in the world
	var block_count = get_tree().get_nodes_in_group("blocks").size()
	if block_count < 80:
		var new_start_height = block_arr[block_arr.size()-1].position.y + 140
		for row_i in range(grid_height):
			for block_i in range(grid_width):
				var block = Block.new(pick_some_object(block_dict))
				block.position.x = (block_size * block_i) + margin_horizontal
				block.position.y = (block_size * row_i) + new_start_height
				block_arr.append(block)
				add_child(block)

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
