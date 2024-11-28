extends StaticBody2D

var velocidade = 200
var direcao = Vector2()
var forca_do_vento = 600

func _physics_process(delta):
	direcao = Vector2()

	direcao.x += forca_do_vento * delta


	direcao.x -= velocidade

	direcao = direcao.normalized() * velocidade

var blow_power := 7000
var max_y_velocity := 500
var player_is_in_blow_area_duration := 0.0

@onready var blow_area := $blow_area as Area2D

func _process(delta):
	var is_player_in_blow_area = false

	for actor in blow_area.get_overlapping_bodies():
		if actor.is_in_group("player"):
			print("personagem entrou")
			if player_is_in_blow_area_duration == 0:
				if actor.velocity.y > 0:
					actor.velocity.y /= 2
			actor.velocity.x += blow_power * delta  # Aplica a força do vento na direção x

			if actor.velocity.x > max_y_velocity:
				actor.velocity.x = max_y_velocity
			is_player_in_blow_area = true

	if is_player_in_blow_area:
		player_is_in_blow_area_duration += 1 * delta
	else:
		player_is_in_blow_area_duration = 0



