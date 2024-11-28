extends Control

func _ready():
	$controls/startBtn.grab_focus()

func _on_startBtn_pressed():
	get_tree().change_scene_to_file("res://2.fases/fase_I/cenas/fase_01.tscn")

func _on_controlBtn_pressed():
	var controlScreen  = load("res://3.tela_pause/cena_janela_controle.tscn").instantiate()
	get_tree().current_scene.add_child(controlScreen)

func _on_quitBtn_pressed():
	get_tree().quit()
