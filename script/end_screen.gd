extends Node2D

var explosion = load("res://scenes/explosion.tscn") 
var explosion_inst
var delta_sum = 0

func _physics_process(delta):
	$black_screen.set_modulate(lerp($black_screen.get_modulate(), Color(0,0,0,1), 0.01))
	explosion_inst = explosion.instance()
	explosion_inst.global_position = Vector2(rand_range(100,900), rand_range(100,1800))
	add_child(explosion_inst)
	explosion_inst.emitting = true
	delta_sum += delta
	
	if delta_sum > 3:
		#restart game
		GameState.reset()
		get_tree().reload_current_scene()
	
