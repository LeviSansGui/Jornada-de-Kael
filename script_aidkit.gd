extends Area2D

func _ready():
	pass
	
func _process(delta):
	pass

func recuperar_vida(body):
	if (body.name=="personagem"):
		scriptglobal.qtd_vidas += 1
		get_parent().queue_free()
