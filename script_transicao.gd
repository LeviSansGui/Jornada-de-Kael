extends CanvasLayer

func change_scene_to_file(path, delay = 0.5):
	$efeito.interpolate_property($sobreposicao, "progress", 0.0, 1.0, 2.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$efeito.start()
	await $efeito.tween_completed

	assert(get_tree().change_scene_to_file(path) == OK)
	
	
	
