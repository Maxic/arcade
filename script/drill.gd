extends KinematicBody2D
class_name Drill

# Preload assets
var sprite_asset = preload("res://scenes/drill_sprite.tscn")

# Preload nodes
onready var dril_pos_node = get_node("/root/main/bot/drill_orbit")

# State variables
var speed = 1000
var velocity = Vector2.ZERO
var bounce_count = 0
var bounce_count_max
var hp
var recoil
var active = false
var charging_time = 0

# Feature flags for functionality (upgrades)
var level_2_upgrade = false
var level_3_upgrade = false

func _init():
	add_to_group("drill")
	set_level(1)

	# Add sprite node
	var sprite = sprite_asset.instance()
	sprite.rotation_degrees = 90
	
	# Add collider node
	var collider = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 10
	collider.shape = shape
	
	# add children
	add_child(sprite)
	add_child(collider)

func _physics_process(delta):
	if GameState.paused:
		return
	
	get_input()
	
	if not active:
		if abs(global_position.y - dril_pos_node.drill_pos.y) < 20:
			global_position = lerp(global_position, dril_pos_node.drill_pos, .9)
		else:
			global_position = lerp(global_position, dril_pos_node.drill_pos, .15)
		rotation_degrees = dril_pos_node.rotation_degrees
	
	if hp == 0 or bounce_count >= bounce_count_max:
		active = false
		reset()
		
	if active:
		do_movement(delta)

func get_input():
	if Input.is_action_pressed("shoot"):
		charging_time += 1
		
		if charging_time > 30:
			set_level(3)
		elif charging_time > 15:
			set_level(2)
	
	if Input.is_action_just_released("shoot") and not active:
		if get_viewport().get_mouse_position().y >= 370:
			active = true
			charging_time = 0

func do_movement(delta):
	velocity = speed * transform.x * delta
	if recoil:
		velocity *= -2
		recoil = false
	var collision_info = move_and_collide(velocity)
	
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		rotation = velocity.angle()
		bounce_count += 1

func set_level(level):
	if not active:
		if level == 3 and level_3_upgrade:
			scale = Vector2(1.5, 1.5)
			bounce_count = 0
			bounce_count_max = 2
			hp = 15
			speed = 500
			return
		if level == 2 and level_2_upgrade:
			scale = Vector2(1.0, 1.0)
			bounce_count = 0
			bounce_count_max = 1
			hp = 5
			speed = 1250
			return
		if level == 1:
			scale = Vector2(.7, .7)
			bounce_count = 0
			bounce_count_max = 1
			hp = 1
			speed = 4500	
		
func reset():
	set_level(1)
