extends Sprite

var delta_sum = 0.0
var t = 0.0

func _process(delta):
	delta_sum += delta

	if delta_sum > 1.5:
		t += delta * 0.4
		global_position = global_position.linear_interpolate(Vector2(0,0), t)
		if global_position == Vector2(0,0):
			queue_free()
	else:
		global_position.y += (sin(delta_sum*5)/1.5)
