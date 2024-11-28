extends Area2D

@export var health = 1 

func _on_vida_body_entered(body):
#	$anim.play("coletado")
#	if scriptglobal.player_health < scriptglobal.max_health:
#		scriptglobal.player_health += 1
#	# Encontra o HUD na cena principal e atualiza a exibição de vida
#	var hud = get_node("/root/fase_01/HUD/HBoxContainer/vida")  # Substitua `NomeDaCenaPrincipal` pelo nome da sua cena principal
#	hud.on_change_life(scriptglobal.player_health)

	if body.has_method("aumentar_vida"):  # Verifica se o corpo tem a função para aumentar a vida
		body.aumentar_vida(health)  # Chama a função de aumentar vida no player
		$anim.play("coletado")
		$audio_vida.play()
	
	
func _on_anim_animation_finished(anim_name):
	if anim_name == "coletado":
		queue_free()
