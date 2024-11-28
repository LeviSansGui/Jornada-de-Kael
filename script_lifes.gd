extends Control

# Declare member variables here. Examples:
var life_size = 32

# Called when the node enters the scene tree for the first time.
func on_change_life(player_health):
	$lifes.size.x = player_health * life_size
