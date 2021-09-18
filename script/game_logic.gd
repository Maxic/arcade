extends Node2D

var block_size
var block_start_height
var block_speed

# randomize vars
var total_weight
var block_dict = {}

# export variables
export var margin_horizontal = 50 # margin on a single side
export var grid_height = 100
export var grid_width = 7

func _ready():
	# add drill to world
	var drill = Drill.new(2)
	drill.name = "drill"
	GameState.drill_node = drill
	drill.set_level(1)
	add_child(drill)
	
	# Populate dict with [roll_weight, acc_weight]
	block_dict["dirt"] = 	[3.0, 0.0]
	block_dict["emerald"] = [0.2, 0.0]
	block_dict["diamond"] = [0.1, 0.0]
	block_dict["ruby"] = 	[0.2, 0.0]
	block_dict["rock"] = 	[1.3, 0.0]
	
	# initialize the dict so blocks can be picked
	init_probabilities(block_dict)
	
	# Spawn blocks of dirt, from halfway down the screen
	block_start_height = get_viewport().size.y / 2
	block_size = (get_viewport().size.x - (margin_horizontal*2)) / grid_width
	
	for row_i in range(grid_height):
		for block_i in range(grid_width):
			var block = Block.new(pick_some_object(block_dict))
			block.position.x = (block_size * block_i) + margin_horizontal
			block.position.y = (block_size * row_i) + block_start_height
			add_child(block)

func _physics_process(_delta):
	if GameState.dead:
		return
		
	for block in get_tree().get_nodes_in_group("blocks"):
		block.position.y -= GameState.block_speed

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
