extends Node2D

var drill_bullet_scene = preload("res://scenes/drill_bullet.tscn")

func _ready():
	var x_pos = get_viewport().size.x / 2
	var y_pos = get_viewport().size.y / 100
	get_parent().position = Vector2(x_pos, y_pos)

func _physics_process(_delta):
	look_at(get_viewport().get_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		var drill_bullet = drill_bullet_scene.instance()
		drill_bullet.position = $drill_static.global_position
		drill_bullet.rotation_degrees = rotation_degrees
		get_node("/root/").add_child(drill_bullet)
