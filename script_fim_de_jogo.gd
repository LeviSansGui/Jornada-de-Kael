
func _ready():
	pass
	
func _on_returnBtn_pressed():
	if get_tree().change_scene_to_file("res://2.fases/fase_I/cenas/fase_01.tscn") != OK:
		print("Algo deu errado!")
	if scriptglobal.is_dead:
		scriptglobal.player_health = 3

