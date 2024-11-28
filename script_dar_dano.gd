extends Area2D

func _process(delta):
	pass
	
func _physics_process(delta):
	get_parent().perc != null
	$direita.move_local_x(20)
	$esquerdaa.move_loval_x(-20)

func _on_hitbox_body_entered(body):
	$direita.position.x = 0 
	$esquerda.position.x = 0
	pass # Replace with function body.
