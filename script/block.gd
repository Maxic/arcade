extends Node2D
class_name Block

# preload assets 
var rock_sprite = preload("res://assets/exploderock_xs.png")
var diamond_sprite = preload("res://assets/diamond_xs.png")
var emerald_sprite = preload("res://assets/emerald_xs.png")
var dirt_sprite = preload("res://assets/dirt_xs.png")
var ruby_sprite = preload("res://assets/ruby_xs.png")

# preload scenes
var gem_diamond_scene = preload("res://scenes/gem_diamond.tscn")
var gem_ruby_scene = preload("res://scenes/gem_ruby.tscn")
var gem_emerald_scene = preload("res://scenes/gem_emerald.tscn")
var collider_scene = preload("res://scenes/block_collider.tscn")
var damaged_block_scene = preload("res://scenes/damaged_block.tscn")

var damaged_block

var dirt_particles_scene = preload("res://scenes/dirt_block_particles.tscn")
var explosion_particles_scene = preload("res://scenes/explosion.tscn")

# preload shaders
var laser_transition_material = preload("res://shaders/laser_transition.tres")


# global vars
var gem_scene
var type
var block_hp
var score
var sprite
var collider
var destroyed_by_laser = false
var cutoff = 0

# constants
const LASER_TRANSISTION_SPEED = 0.01

func _init(block_type):
	self.type = block_type
	
	# General initialization needed for all types of blocks
	sprite = Sprite.new()
	sprite.centered = false
		
	collider = collider_scene.instance()
	collider.position = Vector2(collider.position.x + 70, collider.position.y + 70)
	add_child(collider)
	
	add_to_group("blocks")
	
	# Set type 
	if type == "dirt":
		sprite.texture = dirt_sprite
		gem_scene = null
		block_hp = 1
		score = 1
	elif type == "emerald":
		sprite.texture = emerald_sprite
		gem_scene = gem_emerald_scene
		block_hp = 2
		score = 200
	elif type == "diamond":
		sprite.texture = diamond_sprite
		gem_scene = gem_diamond_scene
		block_hp = 2
		score = 500
	elif type == "ruby":
		sprite.texture = ruby_sprite
		gem_scene = gem_ruby_scene
		block_hp = 2
		score = 300
	elif type == "rock":
		sprite.texture = rock_sprite
		gem_scene = null
		block_hp = 3
		score = 1

	# add children
	add_child(sprite)

func _physics_process(delta):
	if destroyed_by_laser:
		sprite.material = laser_transition_material 
		if collider:
			collider.queue_free()
			collider = null
		cutoff += LASER_TRANSISTION_SPEED * GameState.block_speed
		if cutoff >= 1:
			destroyed_by_laser = false
			queue_free()
		sprite.material.set_shader_param("cutoff", cutoff)
		
func damage(body):
	# damaged_block scene adds a noise texture to make a block look damaged
	var damaged_block = damaged_block_scene.instance()
	if body.is_in_group("drill"):
		block_hp -= 1
		body.hp -= 1
		if block_hp != 0:
			body.recoil()
			add_child(damaged_block)
		
func destroy(object):
	if object.is_in_group("explosion"):
				
		# particles
		var particles
		if type == "rock":
			particles = explosion_particles_scene.instance()
		else:
			particles = dirt_particles_scene.instance()
		particles.position = Vector2(global_position.x + 70, global_position.y + 70)
		particles.emitting = true
		get_parent().add_child(particles)
			
		# gem 
		if gem_scene:
			var gem = gem_scene.instance()
			gem.position = Vector2(global_position.x + 70, global_position.y + 70)
			get_parent().add_child(gem)
		
		GameState.score += score
		
		queue_free()
	
	if object.is_in_group("drill"):
		get_node("/root/main/shake_cam").trigger_shake = true
		
		# particles
		var particles
		if type == "rock":
			particles = explosion_particles_scene.instance()
		else:
			particles = dirt_particles_scene.instance()
		particles.position = Vector2(global_position.x + 70, global_position.y + 70)
		particles.emitting = true
		get_parent().add_child(particles)
			
		# gem 
		if gem_scene:
			var gem = gem_scene.instance()
			gem.position = Vector2(global_position.x + 70, global_position.y + 70)
			get_parent().add_child(gem)
		
		GameState.score += score
		
		queue_free()
