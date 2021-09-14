extends Area2D

func _on_block_collider_body_entered(body):
	get_parent().destroy(body)
