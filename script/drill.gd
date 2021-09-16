extends KinematicBody2D
class_name Drill

# Preload assets
var sprite_asset = preload("res://assets/drill_white.png")

var speed = 1000
var velocity = Vector2.ZERO
var bounce_count = 0
var bounce_count_max
var hp

func _init(drill_level):
	add_to_group("drill")
	
	# Add sprite node
	var sprite = Sprite.new()
	sprite.texture = sprite_asset
	sprite.rotation_degrees = -90
	
	# Add collider node
	var collider = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 25
	collider.shape = shape
	collider.position = Vector2(5, 0)
	
	# level specific drill properties
	if drill_level == 1:
		sprite.scale = Vector2(.6, .4)
		bounce_count_max = 1
		hp = 1		
	elif drill_level == 2:
		sprite.scale = Vector2(1, .8)
		bounce_count_max = 2
		hp = 5
	elif drill_level == 3:
		sprite.scale = Vector2(2, 1.6)
		bounce_count_max = 3
		hp = 20
	
	# add children
	add_child(sprite)
	add_child(collider)

func _physics_process(delta):
	if hp == 0:
		queue_free()
	
	velocity = speed * transform.x * delta
	var collision_info = move_and_collide(velocity)
	
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		rotation = velocity.angle()
		bounce_count += 1
		if bounce_count >= bounce_count_max:
			queue_free()
	
