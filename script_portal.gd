extends Area2D



@onready var changer = get_parent().get_node("transicao")
@export var path : String

func _ready():
	pass # Replace with function body.

func passar_de_fase(body):
	if body.name == "personagem":
		print("colidiu")
		get_tree().change_scene_to_file("res://4.fim_de_jogo/cenas/Final.tscn")
		scriptglobal.checkpoint_pos = 0



	
	
	
	
	
