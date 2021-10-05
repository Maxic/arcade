extends Control

onready var level_2 = get_node("MarginContainer/v_box/level_2")
onready var level_3 = get_node("MarginContainer/v_box/level_3")

func _physics_process(delta):
	if GameState.score > 1000:
		level_2.disabled = false
	else:
		level_2.disabled = true
		
	if GameState.score > 10000:
		level_3.disabled = false
	else:
		level_3.disabled = true

func _on_level_2_pressed():
	Upgrades.drill_level_2 = true

func _on_level_3_pressed():
	Upgrades.drill_level_3 = true
