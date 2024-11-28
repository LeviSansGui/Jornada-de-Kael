extends CanvasLayer

func _on_returnBtn_pressed():
	if get_tree().change_scene_to_file("res://2.fases/fase_II/cenas/fase_02.tscn") != OK:
		print("Algo deu errado!")
	if scriptglobal.is_dead:
		scriptglobal.player_health = 3
