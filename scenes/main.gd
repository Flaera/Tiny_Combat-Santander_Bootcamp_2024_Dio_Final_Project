extends Node2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("POs=",get_node("Player/MobSpawner").position)
	print("POsPlayer=",get_node("Player").position)
	pass
	
