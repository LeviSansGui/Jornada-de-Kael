extends CharacterBody2D

var facing_left = true
var sofreu_dano = false
var vida = 3


@onready var bullet_instance = preload("res://2.fases/fase_I/inimigos/cenas/seed.tscn")
@onready var player = scriptglobal.get("player")

func _physics_process(_delta: float) -> void:	
	if player:
		var distance  = player.global_position.x - self.position.x
		facing_left = true if distance < 0 else false 

	if  facing_left:
		self.scale.x = 1 
	else:
		self.scale.x = -1

func _set_animation():
	var anim = "parado"  # Define a animação padrão como 'idle'
	
	if sofreu_dano ==  true:
		anim = "dano"

	if $anim.assigned_animation != anim:
		$anim.play(anim)
		
func shoot():
	var bullet = bullet_instance.instance()
	get_parent().add_child(bullet)
# warning-ignore:unsafe_property_access
	bullet.global_position = $tiro.global_position
# warning-ignore:unused_argument
func _on_detector_personagem_body_entered(body):
	print(body.name)
	$anim.play("ataque_1")
	
# warning-ignore:unused_argument
func _on_detector_personagem_body_exited(body):
	$anim.play("parado")

#func _on_sofreu_dano_body_entered(body):
#	sofreu_dano = true
#	vida -= 1
#	body.velocity.y -= 300
#	yield(get_tree().create_timer(0.2), "timeout")
#	sofreu_dano = false
#	if vida < 1:
#		queue_free()
#		get_node("sofreu_dano/colisao").set_deferred("disable", true)  

func _on_sofreu_dano_area_entered(area):
	sofreu_dano = true
	vida -= 1
	await get_tree().create_timer(0.3).timeout
	sofreu_dano = false
	if vida < 1:
		queue_free()
		get_node("sofreu_dano/colisao").set_deferred("disable", true)
#	area.queue_free()
