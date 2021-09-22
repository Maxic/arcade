extends Node

var score
var dead
var block_speed
var bg_speed
var drill_node
var drill_pos
var drill_rotation
var score_visible = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	reset()

func reset():
	score = 0
	block_speed = 0.5
	dead = false
