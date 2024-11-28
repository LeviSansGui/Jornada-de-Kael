extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$efeito.interpolate_property($sobreposicao, "progress", 1.0, 0.0, 2.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$efeito.start()

	

