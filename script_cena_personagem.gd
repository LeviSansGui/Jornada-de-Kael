extends CharacterBody2D

var UP = Vector2.UP
var cena_disparo = preload("res://2.fases/fase_III/cenas/cena_disparo.tscn")

var velocity = Vector2.ZERO
var move_speed = 500
var gravity = 300

var jump_force = -300
var max_jumps = 2
var jumps_done = 0

@export var climbing = false

var is_grounded = false  # Inicializa como falso

var player_health = 3
var max_health = 3
var hurted = false

var atirando = false
var direcao  = 1
var facingRight = true

var knockback_dir = 1
var knockback_int = 300

@onready var raycasts = [$ray_dir/raycast, $ray_dir/raycast2]
@onready var climb_up = $climbUp
@onready var climb_down = $climbDown

signal change_life(player_health)

func apply_central_force(force):
	velocity += force

func _ready():
	scriptglobal.set("player", self)
	connect("change_life", Callable(get_parent().get_node("HUD/HBoxContainer/vida"), "on_change_life"))
	emit_signal("change_life", max_health)

# Processa a lógica principal
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = 0

	_get_input()
	set_velocity(velocity)
	set_up_direction(UP)
	move_and_slide()
	velocity = velocity
	
	is_grounded = _check_is_grounded()
	
	if is_grounded and not climbing:
		climbing = false

	_climb_ladder(delta)
	_set_animation()

	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)

# Atualiza a movimentação do personagem
func _get_input():
	var move_direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

	# Define a velocidade e a direção horizontal
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	if move_direction != 0:
		direcao = move_direction  # -1 para esquerda, 1 para direita
		$sprite.scale.x = direcao  # Atualiza a escala do sprite com base na direção

# Função para disparar o projétil
func disparar():
	var obj_disparo = cena_disparo.instantiate()
	get_tree().root.add_child(obj_disparo)

	# Define a posição inicial do disparo com base na direção
	if direcao == 1:
		obj_disparo.global_position = $Position2DDir.global_position
	else:
		obj_disparo.global_position = $Position2DEsq.global_position
		

	# Passa a direção para o projétil
	obj_disparo.get_node("Area2D").direcao = direcao
	print("Direção do disparo enviada ao projétil:", direcao)

# Processa o disparo após a animação terminar
func _on_anim_animation_finished(anim_name):
	if anim_name == "atirando":
		disparar()
		atirando = false  # Reseta o estado de disparo

# Função para escalar a escada
func _climb_ladder(delta):
#	if not climbing:
#		velocity.y += gravity * delta
#	else:
#		velocity.y = 0  # Parar a gravidade ao escalar
	if climbing:
		velocity.y = 0  # Parar a gravidade ao escalar
	else:
		velocity.y += gravity * delta  # Aplicar gravidade quando não está escalando
		
# Função para detectar eventos de input (pulo e movimento em escadas)
func _input(event: InputEvent) -> void:
	# Somente sobe ou desce se estiver escalando
	if climbing:
		if Input.is_action_pressed("ui_up"):
			velocity.y = -move_speed  # Sobe
		elif Input.is_action_pressed("ui_down"):
			velocity.y = move_speed   # Desce
			
	# Se não estiver escalando, o jogador pode pular
	elif event.is_action_pressed("ui_up") and is_grounded and not climbing:
		climbing = false
		velocity.y = jump_force
		jumps_done += 1
		
	#Função de disparo 
	if event.is_action_pressed("disparo") and not atirando:
		$anim.play("atirando")
		atirando = true

# Função para verificar se o personagem está no chão
func _check_is_grounded():
	if climbing:
		return false  # Ignora o chão enquanto estiver escalando
	for raycast in raycasts:
		if raycast.is_colliding():
			return true
	return false

# Função para definir as animações
func _set_animation():
	var anim = "idle"

	if hurted:
		anim = "hit"  # Animação de dano tem prioridade
	elif atirando:
		anim = "atirando"  # Atirar tem prioridade sobre idle/walk
	elif climbing:
		anim = "climb"  # Escalada tem prioridade sobre idle/walk
	elif not is_grounded:
		anim = "jump"  # Pular tem prioridade se não estiver no chão
	elif velocity.x != 0:
		anim = "walk"  # Movimento lateral ativa o "walk"
	else:
		anim = "idle"  # Se nenhuma outra condição for verdadeira, fica "idle"

	if $anim.assigned_animation != anim:
		$anim.play(anim)

func knockback():
	if $right.is_colliding():
		velocity.x = -knockback_dir * knockback_int
	if $left.is_colliding():
		velocity.x = knockback_dir * knockback_int
		
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
	
func _on_hurtbox_body_entered(body):
	player_health -= 1
	hurted = true
	emit_signal("change_life", player_health)
	knockback()
	$audio_dano.play()
	get_node("sofreu_dano/colisao").set_deferred("disable", true)
	await get_tree().create_timer(0.5).timeout
#	get_node("sofreu_dano/colisao").set_deferred("disable", false)
	hurted = false
	if player_health < 1:
		queue_free()
		game_over()

func hit_checkpoint():
	scriptglobal.checkpoint_pos = position.x

func aumentar_vida(valor):
	player_health = min(player_health + valor, 3)  # Limita a vida máxima a 3
	emit_signal("change_life", player_health)  # Emite o sinal para atualizar o HUD
	
func game_over():
	if player_health < 1:
		queue_free()
		scriptglobal.checkpoint_pos = 0  # Reseta o checkpoint
		get_tree().change_scene_to_file("res://4.fim_de_jogo/cenas/cena_fim_de_jogo_1.tscn")

func _on_sofreu_dano_area_entered(area):
	player_health -= 1
	hurted = true
	emit_signal("change_life", player_health)
#	knockback()
	var colisao_node = get_node("sofreu_dano/colisao")
	if colisao_node:
		colisao_node.set_deferred("disable", true)
	await get_tree().create_timer(0.5).timeout
	get_node("sofreu_dano/colisao").set_deferred("disable", false)
	hurted = false
	
	if player_health < 1:
		queue_free()
		game_over()
		
