extends Area2D

export var speed : float = 1.0
var particles_scene = preload("res://scenes/dirt_block_particles.tscn")

func _on_dirt_block_body_entered(body):
	if body.is_in_group("drill"):
		get_node("/root/main/shake_cam").trigger_shake = true
		
		var particles = particles_scene.instance()
		particles.position = global_position
		particles.emitting = true
		get_parent().add_child(particles)
		
		queue_free()

func _physics_process(delta):
	position.y -= speed
