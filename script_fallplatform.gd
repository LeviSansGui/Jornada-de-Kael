extends CharacterBody2D

@onready var anim = $anim
@onready var timer = $tempo

@onready var reset_position = global_position

var velocity = Vector2.ZERO
var gravity = 720
var is_triggered = false
@export var reset_timer = 3.0

func _ready():
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta

func collide_with(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !is_triggered:
		is_triggered = true
		anim.play("shaker")
		velocity = Vector2.ZERO  # Zera a velocidade para começar a queda

func _on_anim_animation_finished(anim_name: String) -> void:
		set_physics_process(true)
		timer.start(reset_timer)

func _on_timer_timeout():
	set_physics_process(false)
	await get_tree().physics_frame
	# Desativa a colisão para reposicionar sem interferência
	var temp = collision_layer
	collision_layer = 0
	
	# Reseta a posição e velocidade
	global_position = reset_position
	velocity = Vector2.ZERO
	
	await get_tree().physics_frame
	# Ativa a camada de colisão e prepara para nova ativação
	collision_layer = temp
	is_triggered = false
