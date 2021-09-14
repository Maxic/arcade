extends Node2D
class_name Block

# preload assets and scenes
var rock_sprite = preload("res://assets/rock_xs.png")
var diamond_sprite = preload("res://assets/diamond_xs.png")
var emerald_sprite = preload("res://assets/emerald_xs.png")
var dirt_sprite = preload("res://assets/dirt_xs.png")
var ruby_sprite = preload("res://assets/ruby_xs.png")

var collider_scene = preload("res://scenes/block_collider.tscn")
var particles_scene = preload("res://scenes/dirt_block_particles.tscn")

func _init(type):
	# General initialization needed for all types of blocks
	var sprite = Sprite.new()
	sprite.centered = false
	
	var collider = collider_scene.instance()
	collider.position = Vector2(collider.position.x + 70, collider.position.y + 70)
	add_child(collider)
	
	add_to_group("blocks")
	
	# Set type 
	if type == "dirt":
		sprite.texture = dirt_sprite
	elif type == "emerald":
		sprite.texture = emerald_sprite
	elif type == "diamond":
		sprite.texture = diamond_sprite
	elif type == "ruby":
		sprite.texture = ruby_sprite
	elif type == "rock":
		sprite.texture = rock_sprite

	# add children
	add_child(sprite)

func destroy(body):
	if body.is_in_group("drill"):
		get_node("/root/main/shake_cam").trigger_shake = true
		
		var particles = particles_scene.instance()
		particles.position = Vector2(global_position.x + 70, global_position.y + 70)
		particles.emitting = true
		get_parent().add_child(particles)
		
		queue_free()
