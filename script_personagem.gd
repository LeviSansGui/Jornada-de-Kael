extends CharacterBody2D

var velocidade = 300
var forca_pulo = 900
var gravidade = 30
var mov = Vector2.ZERO
var pulando  = false
var atirando = false
var direcao  = 1

func _process(delta):
	mov.x = 0
	mov.y += gravidade
	if (not atirando):
		if (Input.is_action_pressed("ui_left")):
			mov.x = -velocidade
			$Sprite2D.flip_h = true
			direcao = -1
		elif (Input.is_action_pressed("ui_right")):
			mov.x = velocidade
			$Sprite2D.flip_h = false
			direcao = 1

	if (Input.is_action_just_pressed("ui_up") and is_on_floor()):
		mov.y = -forca_pulo

	if (is_on_floor()):
		pulando = false
		if (not atirando):
			if (mov.x==0):
				$AnimationPlayer.play("parado")
			else:
				$AnimationPlayer.play("andando")	
				
			if (Input.is_action_just_pressed("disparo")):
				$AnimationPlayer.play("atirando")
				atirando = true
				
		if ($AnimationPlayer.current_animation==""):
			atirando = false
			
	elif (not pulando):
		$AnimationPlayer.play("pulando")
		pulando = true
		atirando = false
			
	set_velocity(mov)
	set_up_direction(Vector2(0,-1))
	move_and_slide()
	mov = velocity

func disparar(anim_name):
	
	if (anim_name=="atirando"):
		var cena_disparo = preload("res://2.fases/fase_III/cenas/cena_disparo.tscn") 
		var obj_disparo  = cena_disparo.instantiate()
		
		get_tree().root.add_child(obj_disparo)
		
		if (direcao==1):
			obj_disparo.global_position = $Position2DDir.global_position
		elif (direcao==-1):
			obj_disparo.global_position = $Position2DEsq.global_position
		
		obj_disparo.get_node("Area2D").direcao = direcao
		
		
		
		
		
		
		
		
		
		
		
