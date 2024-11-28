extends Area2D

func _on_area_queda_body_entered(body):
	print(body.name)
	get_tree().change_scene_to_file("res://2.fases/fase_I/cenas/fase_01.tscn")
