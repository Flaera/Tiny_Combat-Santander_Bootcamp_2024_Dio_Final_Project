extends Node2D


export var damage_hit = 3


func dealDamage():
	var bodies: Array = get_node("Area2D").get_overlapping_bodies()
	for body in bodies:
		if (body.is_in_group("enemies")):
			body.damage = damage_hit
