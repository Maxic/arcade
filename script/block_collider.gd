extends Area2D

func _on_block_collider_body_entered(body):
	get_parent().damage(body)
	if get_parent().block_hp < 1:
		get_parent().destroy(body)
