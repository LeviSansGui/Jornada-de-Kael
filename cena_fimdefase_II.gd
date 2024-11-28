extends Area2D

@onready var changer = get_parent().get_node("transicao")
@export var path : String

func _ready():
	pass # Replace with function body.

func _on_goal_body_entered(body):
	if body.name == "personagem":
		print("colidiu")
		changer.change_scene_to_file("res://2.fases/fase_III/cenas/fase_03.tscn")
		scriptglobal.checkpoint_pos = 0
