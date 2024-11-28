extends CharacterBody2D

var vida = 3
var rain_scene = preload("res://2.fases/fase_III/cenas/CenaChuva.tscn")

func _ready():
	$Timer.start()
	get_tree().root.print_tree()

func _process(delta):
	var personagem = get_tree().root.find_child("personagem", true, false)  # Substitua "Personagem" pelo nome exato do nó principal do personagem.
	if personagem:
		$Sprite2D/Direita.look_at(personagem.global_position)
	else:
		print("Personagem não encontrado na árvore.")
	
	if (vida==0):
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("morrendo")
		$Timer.stop()

func dispara():
	var cena_disparo = preload("res://2.fases/fase_III/inimigos/Cena_Disparo_Vilao.tscn")
	var objeto_disparo = cena_disparo.instantiate()
	get_parent().add_child(objeto_disparo)
	objeto_disparo.global_position = $Sprite2D/Direita.global_position
	objeto_disparo.rotation = $Sprite2D/Direita.rotation
	
func causar_dano(body):
	if (body.name=="personagem"):
		body.get_node("AnimationPlayer2").play("dano")
		body.get_node("AudioStreamPlayer").play()
	
func eliminar_inimigo(anim_name):
	if (anim_name=="morrendo"):
		get_parent().queue_free()
