extends Area2D

func _on_block_collider_body_entered(body):
	
	if body.is_in_group("drill"):
		get_parent().damage(body)
		scale *= .95
		if get_parent().block_hp < 1:
			get_parent().call_deferred("destroy", body)
