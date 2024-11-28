extends Node2D	

func _ready():
	pass # Replace with function body.

var velocidade = 5
var mov = Vector2.ZERO
func _process(delta):
	mov.x = velocidade
	translate(mov)
	

func destruir_per(body):
	if (body.name=="personagem"):
		body.player_health-=1
		get_parent().queue_free()

