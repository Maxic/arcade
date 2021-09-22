extends Sprite

var charging_time = 0

func _ready():
	var x_pos = get_viewport().size.x / 2
	var y_pos = (get_viewport().size.y - get_viewport().size.y) + 180
	global_position = Vector2(x_pos, y_pos)

func _physics_process(_delta):
	if GameState.dead:
		return
	
	# default scale is 1.1
	$drill_orbit/drill_static.scale = Vector2(0.5, 0.5)
	
	if Input.is_action_pressed("shoot"):
		charging_time += 1
		
		if charging_time > 30:
			GameState.drill_node.set_level(3)
		elif charging_time > 15:
			GameState.drill_node.set_level(2)
	
	if Input.is_action_just_released("shoot") and not GameState.drill_node.active:
		GameState.drill_node.active = true
		
		# reset stuff
		charging_time = 0
