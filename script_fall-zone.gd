extends Area2D

func _on_fallzone_body_entered(body):
	print(body. name)
	if get_tree().change_scene_to_file("res://levels/fase_I/cenas/level_01.tscn") != OK:
					print("Algo deu errado!")
