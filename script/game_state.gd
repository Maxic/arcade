extends Node

var score
var dead
var block_speed

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	reset()

func reset():
	score = 0
	block_speed = .5
	dead = false
