extends CharacterBody2D

var velx = 0
var impulsoy = 0 
var chao = Vector2(0, -1)

func _physics_process(delta):
	if !is_on_floor():
		impulsoy += delta
	if 	impulsoy > 1:
		impulsoy = 1
		
	var gravidade = Vector2(0, impulsoy*velx)
	set_velocity(gravidade)
	set_up_direction(chao)
	move_and_slide()
	
	position = Vector2(position.x + velx, position.y)
	if velx == 0:
		$direita.hide()
		$esquerda.hide()
		$parado.show()
		
func _on_detectorDireito_body_entered(body):
	velx = 3
	$direita.show()
	$esquerda.hide()
	$parado.hide()
	pass # Replace with function body.


func _on_detectorEsquerdo_body_entered(body):
	velx = -3
	$direita.hide()
	$esquerda.show()
	$parado.hide()
	pass # Replace with function body.


func _on_detectorDireito_body_exited(body):
	velx = 0 
	pass # Replace with function body.


func _on_detectorEsquerdo_body_exited(body):
	velx = 0
	pass # Replace with function body.
