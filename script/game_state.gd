extends Node

var score
var dead

func _ready():
	reset()

func reset():
	score = 0
	dead = false
