extends CharacterBody2D

@export var money_instance # (Array, PackedScene)
@export var money = 0 # (int, 0, 20, 1)


var divX = 2 
var divY = 2 

func destroy():
	money -= 1
	if money < 0:
		var region = $texture.region_rect
		var texture = $texture.texture
		var sizeX = region.size.x / divX
		var sizeY = region.size.Y / divY
		
		for h in range(divY):
			for w in range(divX):
				var rect = Rect2(region.position.x + (sizeX * w), region.position.y + (sizeY * h), sizeX, sizeY)
				var sprite = Sprite2D.new()
				sprite.texture = texture
				sprite.region_enable = true 
				sprite.region_rect = rect
				sprite.centered = false 
				sprite.global_position = $texture.global_position
				var rigid = RigidBody2D.new()
				rigid.add_child(sprite)
				get_parent().add_child(rigid)
				rigid.apply_impulse(Vector2(randf_range(-50,50),randf_range(-100,-150)), Vector2.ZERO)	
				queue_free()
	else:
				create_money()
				$anim.play("hit")
				
func create_money():
	var money_number = round(randf_range(0, money_instance.size() -1))
#	var money = money_instance(money_number).instance()
	money.gloabal_position = $spawnPoint.global_position
#	money.apply_impulse( Vector2(rand_range)(30, -30), -80))	
	money.apply_impulse(Vector2(randf_range(-50,50),randf_range(-100,-150)), Vector2.ZERO)	
	get_parent().call_deferred("add_child", money)
	
	

