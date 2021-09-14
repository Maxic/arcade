extends Area2D

# particles
var particles_scene = preload("res://scenes/dirt_block_particles.tscn")

func _ready():
	add_to_group("blocks")

func _on_dirt_block_body_entered(body):
	if body.is_in_group("drill"):
		get_node("/root/main/shake_cam").trigger_shake = true
		
		var particles = particles_scene.instance()
		particles.position = global_position
		particles.emitting = true
		get_parent().add_child(particles)
		
		queue_free()
