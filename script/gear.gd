extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if self.name == "gear_right":
		self.rotate(-(GameState.block_speed/20.0))
	if self.name == "gear_left":
		self.rotate((GameState.block_speed/20.0))
	
