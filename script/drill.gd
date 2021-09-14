extends KinematicBody2D

var speed = 1000
var velocity = Vector2.ZERO
var bounce_count = 0
var bounce_count_max = 2
var blocks_destroyed = 0

func _ready():
	add_to_group("drill")

func _physics_process(delta):
	if blocks_destroyed >=  1:
		queue_free()
	
	velocity = speed * transform.x * delta
	var collision_info = move_and_collide(velocity)

	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		rotation = velocity.angle()
		bounce_count += 1
		if bounce_count >= bounce_count_max:
			queue_free()

