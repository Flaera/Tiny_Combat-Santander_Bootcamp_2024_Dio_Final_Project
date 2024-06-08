extends KinematicBody2D

onready var velocity: Vector2
onready var is_running: bool = false
onready var player: Object = get_node("/root/Node2D/Player")
onready var cooldown: float = 0.0
onready var play_cooldown: bool = false
onready var damage: int = 0
export onready var health = 10
export var speed: float = 1
export var damage_hit: int = 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var player_position: Vector2 = player.position
	var normal = (player_position - position).normalized()
	var target_velocity: Vector2 = normal*speed*100.0
	velocity = lerp(velocity, target_velocity, 0.05)
	move_and_slide(velocity, Vector2.UP, true)
	get_node("AnimatedSprite").play("run_enemy")

	#Deal damage in player:
	var bodies: Array = get_node("Area2DEnemy").get_overlapping_bodies()
	for body in bodies:
		if "Player" in body.name and cooldown==0.0:
			#print("body=",body)
			body.get_damage = body.get_damage + damage_hit
			play_cooldown = true
		if (play_cooldown==true):
			cooldown+=_delta
			if (cooldown>5.0):
				cooldown=0.0
				play_cooldown = false

	#Get damage from player:
	if (damage!=0):
		print("hp_enemy=",health)
		health -= damage
		damage = 0