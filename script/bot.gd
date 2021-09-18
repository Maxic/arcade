extends Sprite

var charging_time = 0
var drill_level = 1

func _ready():
	var x_pos = get_viewport().size.x / 2
	var y_pos = (get_viewport().size.y - get_viewport().size.y) + 180
	global_position = Vector2(x_pos, y_pos)

func _physics_process(delta):
	if GameState.dead:
		return
	
	# default scale is 1.1
	$drill_orbit/drill_static.scale = Vector2(0.5, 0.5)
	
	if Input.is_action_pressed("shoot"):
		charging_time += 1
		
		if charging_time > 90:
			drill_level = 3
			$drill_orbit/drill_static.scale = Vector2(1, 1)
		elif charging_time > 60:
			drill_level = 2
			$drill_orbit/drill_static.scale = Vector2(0.75, 0.75)
			
	
	if Input.is_action_just_released("shoot"):
		var drill_bullet = Drill.new(drill_level)
		drill_bullet.position = $drill_orbit/drill_static.global_position
		drill_bullet.rotation_degrees = $drill_orbit.rotation_degrees
		get_node("/root/main/").add_child(drill_bullet)
		
		# reset stuff
		charging_time = 0
		drill_level = 1
