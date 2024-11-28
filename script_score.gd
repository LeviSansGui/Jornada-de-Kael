extends Label
# Called when the node enters the scene tree for the first time.
func _process(delta):
	text = "0" + String(scriptglobal.money)
	if scriptglobal.money >= 10:
		text = "" + String(scriptglobal.money)
