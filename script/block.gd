extends Node2D
class_name Block

# preload assets and scenes
var rock_sprite = preload("res://assets/rock_xs.png")
var diamond_sprite = preload("res://assets/diamond_xs.png")
var emerald_sprite = preload("res://assets/emerald_xs.png")
var dirt_sprite = preload("res://assets/dirt_xs.png")
var ruby_sprite = preload("res://assets/ruby_xs.png")

var gem_diamond_scene = preload("res://scenes/gem_diamond.tscn")
var gem_ruby_scene = preload("res://scenes/gem_ruby.tscn")
var gem_emerald_scene = preload("res://scenes/gem_emerald.tscn")
var collider_scene = preload("res://scenes/block_collider.tscn")
var particles_scene = preload("res://scenes/dirt_block_particles.tscn")

# global vars
var gem_scene

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
		gem_scene = null
	elif type == "emerald":
		sprite.texture = emerald_sprite
		gem_scene = gem_emerald_scene
	elif type == "diamond":
		sprite.texture = diamond_sprite
		gem_scene = gem_diamond_scene
	elif type == "ruby":
		sprite.texture = ruby_sprite
		gem_scene = gem_ruby_scene
	elif type == "rock":
		sprite.texture = rock_sprite
		gem_scene = null

	# add children
	add_child(sprite)

func destroy(body):
	if body.is_in_group("drill"):
		get_node("/root/main/shake_cam").trigger_shake = true
		
		# particles
		var particles = particles_scene.instance()
		particles.position = Vector2(global_position.x + 70, global_position.y + 70)
		particles.emitting = true
		get_parent().add_child(particles)
		
		# gem 
		if gem_scene:
			var gem = gem_scene.instance()
			gem.position = Vector2(global_position.x + 70, global_position.y + 70)
			get_parent().add_child(gem)
		
		queue_free()
