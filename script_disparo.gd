extends Area2D

@export var speed = 500  # Velocidade do projétil
var direcao = 1  # 1 para direita, -1 para esquerda
@onready var sprite = $Sprite2D

func _process(delta):
	# Move o projétil na direção especificada
	position.x += speed * direcao * delta

	# Remove o projétil se sair dos limites da tela
	if position.x > 2000 or position.x < -2000:  # Ajuste os limites conforme necessário
		queue_free()
	
	 # Configura a direção do projétil
	if direcao == -1:
		sprite.flip_h = true  # Inverte o sprite para a esquerda
	else:
		sprite.flip_h = false  # Mantém o sprite virado para a direita

func destruir_inimigo(body):
	if (body.name=="inimigo"):
		body.vida-=1	
#		body.velocidade = 0
		get_parent().queue_free()
