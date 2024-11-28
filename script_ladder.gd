extends Area2D

# Quando o corpo entrar na área da escada
func _on_ladder_body_entered(body):
	if body.is_in_group("climber"):
		body.climbing = true # Ativa o estado de escalar
		
# Quando o corpo sair da área da escada
func _on_ladder_body_exited(body):
	if body.is_in_group("climber"):
		body.climbing = false  # Desativa o estado de escalar
		
