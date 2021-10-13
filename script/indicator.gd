extends Sprite


var diamond_sprite = load("res://assets/gemindicator_diamond.png")

var emerald_sprite = load("res://assets/gemindicator_emerald.png")

var ruby_sprite = load("res://assets/gemindicator_ruby.png")

var empty_sprite = load("res://assets/gemindicator_empty.png")

var current_color = "empty"

func set_color(gem_color):

	if gem_color == "diamond":
		self.set_texture(diamond_sprite)
	if gem_color == "emerald":
		self.set_texture(emerald_sprite)
	if gem_color == "ruby":
		self.set_texture(ruby_sprite)
	if gem_color == "empty":
		self.set_texture(empty_sprite)
	current_color = gem_color
