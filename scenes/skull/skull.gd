extends Node2D

func _process(_delta):
	if (get_node("AnimationPlayer").is_playing()==false):
		queue_free()
