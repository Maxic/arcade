extends Control

# preload assets
var bought_state_level_2 = preload("res://assets/powerup_box_drill_lvl2_bought.png")

onready var level_2 = get_node("MarginContainer/v_box/level_2")
onready var level_3 = get_node("MarginContainer/v_box/level_3")

func _physics_process(delta):
	if GameState.score > 1000 and Upgrades.drill_level_2 == false:
		level_2.disabled = false
	else:
		level_2.disabled = true
		
	if GameState.score > 10000:
		level_3.disabled = false
	else:
		level_3.disabled = true

func _on_level_2_pressed():
	Upgrades.drill_level_2 = true
	var disabled_stylebox = level_2.get_stylebox('disabled')
	disabled_stylebox.texture = bought_state_level_2

func _on_level_3_pressed():
	Upgrades.drill_level_3 = true
