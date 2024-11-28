extends Area2D

@export var money = 1

func _on_money_body_entered(body):
		$anim.play("collected")
		$audio_dinheiro.play()
		scriptglobal.money += money
		
		
	
func _on_anim_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()
		
