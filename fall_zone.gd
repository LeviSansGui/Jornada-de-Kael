extends Area2D



func _on_fall_zone_body_entered(body):
	print(body.name)
	get_tree().reload_current_scene()
