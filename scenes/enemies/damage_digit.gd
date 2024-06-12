extends Node2D


var damage_value: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Node2D/Label").text = str(damage_value)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
