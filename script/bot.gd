extends Sprite

var charging_time = 0
var drill_level = 1

func _ready():
	var x_pos = get_viewport().size.x / 2
	var y_pos = get_viewport().size.y / 25
	global_position = Vector2(x_pos, y_pos)

func _physics_process(delta):
	if Input.is_action_pressed("shoot"):
		charging_time += 1
		
		if charging_time > 120:
			drill_level = 3
			print("level_3")
		elif charging_time > 30:
			drill_level = 2
			print("level_2")
	
	if Input.is_action_just_released("shoot"):
		var drill_bullet = Drill.new(drill_level)
		drill_bullet.position = $drill_orbit/drill_static.global_position
		drill_bullet.rotation_degrees = $drill_orbit.rotation_degrees
		get_node("/root/main/").add_child(drill_bullet)
		
		# reset stuff
		charging_time = 0
		drill_level = 1
