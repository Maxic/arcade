extends Sprite

export var shake_power = 2
export var shake_time = 0.3


var diamond_sprite = load("res://assets/robody_diamond.png")

var emerald_sprite = load("res://assets/robody_emerald.png")

var ruby_sprite = load("res://assets/robody_ruby.png")

var empty_sprite = load("res://assets/robody.png")

var current_charge = "empty"

func _physics_process(delta):
	var offsetx = randf() * (shake_power/2.0)
	var offsety = randf() * (shake_power*2.0)

	offset.x = offsetx
	offset.y = offsety

	$indicators/indicator_1.offset.x = offsetx
	$indicators/indicator_1.offset.y = offsety
	$indicators/indicator_2.offset.x = offsetx
	$indicators/indicator_2.offset.y = offsety
	$indicators/indicator_3.offset.x = offsetx
	$indicators/indicator_3.offset.y = offsety


func set_charge(charge_color):

	if charge_color == "diamond":
		self.set_texture(diamond_sprite)
	if charge_color == "emerald":
		self.set_texture(emerald_sprite)
	if charge_color == "ruby":
		self.set_texture(ruby_sprite)
	if charge_color == "empty":
		self.set_texture(empty_sprite)
	current_charge = charge_color
