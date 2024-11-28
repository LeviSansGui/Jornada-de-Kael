extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (ScriptGlobal.qtd_vidas==1):
		$AnimationPlayer.play("uma_vida")
	elif (ScriptGlobal.qtd_vidas==2):
		$AnimationPlayer.play("duas_vidas")
	elif (ScriptGlobal.qtd_vidas==3):
		$AnimationPlayer.play("tres_vidas")
	elif (ScriptGlobal.qtd_vidas==4):	
		$AnimationPlayer.play("quatros_vidas")
		
	if (ScriptGlobal.qtd_vidas==0):	
		get_tree().change_scene_to_file("res://cena_game_over.tscn")	
		
		
func fazer_gota_fogo():
	var cena_chuva_fogo = preload("res://CenaChuva.tscn")
	
	var obj1 = cena_chuva_fogo.instantiate()
	get_parent().add_child(obj1)
	randomize()
	obj1.global_position.x = randf_range(0,get_viewport_rect().size.x)
	obj1.global_position.y = -10
	
	
	var obj2 = cena_chuva_fogo.instantiate()
	get_parent().add_child(obj2)
	randomize()
	obj2.global_position.x = randf_range(0,get_viewport_rect().size.x)
	obj2.global_position.y = -600
	
	
	var obj4 = cena_chuva_fogo.instantiate()
	get_parent().add_child(obj4)
	randomize()
	obj4.global_position.x = randf_range(0,get_viewport_rect().size.x)
	obj4.global_position.y = -300

	var obj3 = cena_chuva_fogo.instantiate()
	get_parent().add_child(obj3)
	randomize()
	obj3.global_position.x = randf_range(0,get_viewport_rect().size.x)
	obj3.global_position.y = -900


	

