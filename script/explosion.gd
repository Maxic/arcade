extends Area2D

var emitting = false
var timer = 0

func _ready():
	add_to_group("explosion")

func _physics_process(delta):
	if timer == 5:
		$explosion_collider.disabled = false
	
	if timer == 40:
		queue_free()
	
	if emitting:
		$explosion_particles.emitting = true
		emitting = false
		# start timer
		timer = 1
		
	if timer > 0:
		timer += 1

func _on_explosion_area_entered(area):
	var block = area.get_parent()
	
	if block.is_in_group("blocks"):
		block.destroy(self)
