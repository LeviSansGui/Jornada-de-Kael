extends Control

# Declare member variables here. Examples:
#export (int) var minutes = 0
#export (int) var seconds = 0
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if minutes > 0 and seconds <=0:
#		minutes -= 1 
#		seconds = 60
#
#	if seconds >= 10:
#		$seconds.set_text(":" + str(seconds))
#	else:
#		$seconds.set_text(":0" + str(seconds))
#	print(seconds)
#
#	if minutes >= 10:
#		$minutes.set_text(str(minutes))
#	else:
#		$minutes.set_text("0" + str(minutes))
#	print(minutes)
#
#	if seconds <= 0:
#		$Timer.stop()
##		yield(get_tree().create_timer(1),"timeout")
#		if get_tree().reload_current_scene() != OK:
#			print("Algo deu errado!")
#		get_tree().reload_current_scene() 
#
#func _on_Timer_timeout() -> void:
#	seconds -= 1

# Sugestão de um seguidor 

#Primeiro: O HUD pode permanecer no Singleton, só que cada vez que mudar algo na estrutura dele tem que 
# salvar e ir em Project -> Reload Current Project ou fechar e abrir novamente a Godot.

#Segundo: no temporizador não é preciso fazer toda essa gambiarra de colocar 2 Labels, basta usar os 
# formatadores de String. No meu caso chamei a Label de time. 
#$time.set_text("%02d:%02d" % [minutes, seconds])

#Quanto aos Strings, existe uma grande variedade de formatadores  que podem ser consultados dando um 
# Google em "GDScript format strings", dos quais  deixo alguns exemplos dos que eu mais uso, os de int e 
# de float.
#print("Hora: %02d:%02d:%02d" % [2, 3, 7])
#print("Às %02d:%02d recebeu R$ %2.2f dos quais gastou %0.2f" % [9, 3, 100, 25.8])
#
#Caso queira que apresente uma vírgula em vez de ponto decimal:
#print(String("Às %02d:%02d recebeu R$ %2.2f dos quais gastou %0.2f" % [9, 3, 100, 25.8] ).replace(".", ","))
