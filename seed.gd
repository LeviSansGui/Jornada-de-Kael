extends Area2D

var velocity = Vector2.ZERO
var shoot_speed = -150

func _physics_process(delta: float) -> void:
	velocity.x = shoot_speed * delta
	
	translate(velocity)

func _on_clearNode_screen_exited():
	queue_free()
