extends KinematicBody2D

var speed = 1000
var velocity = Vector2.ZERO
var bounce_count = 0

func _ready():
	add_to_group("drill")

func _physics_process(delta):

	
	velocity = speed * transform.x * delta
	var collision_info = move_and_collide(velocity)

	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		rotation = velocity.angle()
		bounce_count += 1
		if bounce_count >= 3:
			queue_free()

