extends Area2D

func _on_trampoline_body_entered(body):
	body.velocity.y = body.jump_force
	$audio_tramp.play()
	$anim.play("jump")
