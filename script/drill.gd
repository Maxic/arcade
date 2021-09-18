extends KinematicBody2D
class_name Drill

# Preload assets
var sprite_asset = preload("res://scenes/drill_sprite.tscn")

var speed = 1000
var velocity = Vector2.ZERO
var bounce_count = 0
var bounce_count_max
var hp
var recoil

func _init(drill_level):
	add_to_group("drill")
	
	# Add sprite node
	var sprite = sprite_asset.instance()
	sprite.rotation_degrees = 90
	
	# Add collider node
	var collider = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 10
	collider.shape = shape
	
	
	# level specific drill properties
	if drill_level == 1:
		sprite.scale = Vector2(.5, .5)
		bounce_count_max = 1
		hp = 1		
		collider.position = Vector2(25, 0)
	elif drill_level == 2:
		sprite.scale = Vector2(0.75, 0.75)
		bounce_count_max = 2
		hp = 10
		collider.position = Vector2(60, 0)
	elif drill_level == 3:
		sprite.scale = Vector2(1, 1)
		bounce_count_max = 3
		hp = 15
		collider.position = Vector2(135, 0)
	
	# add children

	add_child(sprite)
	add_child(collider)

func _physics_process(delta):
	if hp == 0:
		queue_free()
	
	velocity = speed * transform.x * delta
	if recoil:
		velocity *= -2
		recoil = false
	var collision_info = move_and_collide(velocity)
	
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		rotation = velocity.angle()
		bounce_count += 1
		if bounce_count >= bounce_count_max:
			queue_free()

func recoil():
	recoil = true	

