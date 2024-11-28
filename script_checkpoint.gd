extends Area2D

func _on_checkpoint_body_entered(body):
	if body.name == "personagem":
		print("passou")
		body.hit_checkpoint()
		$anim.play("passou")
#		$colisao.queue_free()
