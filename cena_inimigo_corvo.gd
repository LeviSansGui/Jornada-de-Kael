extends CharacterBody2D

@export var rapidez = 64
@export var vida = 1
var velocidade = Vector2.ZERO
var direcao = 1

var sofreu_dano = false  # Controla o estado do inimigo

func _physics_process(_delta: float) -> void:
	velocidade.x = rapidez * direcao
	
	# Troca de direção quando colidir com algo
	if $ray_dir.is_colliding():
		$ray_dir.scale.x *= -1
		direcao *= -1
	
	# Define a direção da textura
	$textura.flip_h = direcao == -1
	
	set_velocity(velocidade)
	move_and_slide()
	velocidade = velocity

# Função para a área "dar_dano" (acima do inimigo)
func _on_dar_dano_body_entered(body):
	if body.is_in_group("player"):  # Verifica se o jogador está colidindo
		if body.velocity.y > 0:  # Jogador está caindo
			vida -= 1
			sofreu_dano = true  # Marca o inimigo como atingido
			body.velocity.y = -300  # Dá impulso no jogador
			
			if vida <= 0:
				queue_free()  # Remove o inimigo
		else:
			# Se o jogador não está caindo, ele não deve matar o inimigo
			body.hurted = false  # Evita dano ao jogador

# Função para a área "sofreu_dano" (laterais/inferior do inimigo)
func _on_sofreu_dano_body_entered(body):
	if body.is_in_group("player") and not sofreu_dano:  # Dano ao jogador apenas se o inimigo não sofreu dano
		body.hurted = true  # Aplica dano ao jogador
