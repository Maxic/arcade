extends Node2D

var explosion = load("res://scenes/explosion.tscn") 
var label = preload("res://scenes/end_screen_label.tscn")
var explosion_inst
var delta_sum = 0

func _physics_process(delta):
	$black_screen.set_modulate(lerp($black_screen.get_modulate(), Color(0,0,0,1), 0.01))
	GameState.score_visible = false	
	if delta_sum > 5:
		var label_instance = label.instance()
		label_instance.get_node("Label").text = label_instance.get_node("Label").text +  " " + str(GameState.score)
		get_node("/root/main/ui_layer/ui").add_child(label_instance)
	else:
		explosion_inst = explosion.instance()
		explosion_inst.global_position = Vector2(rand_range(100,900), rand_range(100,1800))
		add_child(explosion_inst)
		explosion_inst.emitting = true

	
	if Input.is_action_just_pressed("restart"):
		#restart game
		GameState.reset()
		get_tree().reload_current_scene()
		
	delta_sum += delta
	
