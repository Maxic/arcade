extends Node

var score
var dead
var block_speed

func _ready():
	reset()

func reset():
	score = 0
	block_speed = .5
	dead = false
