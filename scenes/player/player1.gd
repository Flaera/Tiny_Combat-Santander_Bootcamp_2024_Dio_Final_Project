extends KinematicBody2D

export var speed: float = 5
export var health: int = 10
export var health_max: int = 10
export var damage_hit: int = 4
export var attack_speed: float = 0.3
onready var velocity: Vector2
onready var is_running: bool = false
onready var get_damage: int = 0
onready var input: Vector2 = Vector2(0.0,0.0)
onready var play_damage_cooldown: bool = false
onready var damage_cooldown: float = 0.0
onready var scene_skull: PackedScene = preload("res://scenes/skull/skull.tscn")
onready var playing: bool = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if (playing==true):
		input = Input.get_vector("move_left","move_right","move_up", "move_down")
	#print("input=",input)
	var target_velocity: Vector2 = input*speed*100.0
	velocity = lerp(velocity, target_velocity, 0.05)
	move_and_slide(velocity, Vector2.UP, true)
	
	var was_running: bool = is_running
	is_running = not(input.is_equal_approx(Vector2(0.0,0.0)))
	if (was_running!=is_running):
		if (is_running):
			get_node("AnimationPlayer").play("run")
		else: get_node("AnimationPlayer").play("idle")
		
	if (input[0]>0):
		get_node("WarriorYellow").flip_h = false
	elif (input[0]<0):
		get_node("WarriorYellow").flip_h = true
		
	if (Input.is_action_just_pressed("ui_accept") and input.is_equal_approx(Vector2(0.0,0.0))
	 and play_damage_cooldown==false and playing==true):
		get_node("AnimationPlayer").play("attack0")
		play_damage_cooldown = true
	if (play_damage_cooldown==true):
		damage_cooldown += _delta
		if (damage_cooldown>attack_speed):
			damage_cooldown = 0.0
			play_damage_cooldown = false

	getDamageOfEnemy()
	#print("hp=",health)
	var areas = get_node("Area2D").get_overlapping_areas()
	#print("areas=",areas)
	for area in areas:
		if (area.name=="MeatArea2D"):
			health=addLife(area.get_parent().regeneration_amount)
			area.get_parent().queue_free()
		


func die():
	if (health<=0 and playing==true):
		var scn: Object = scene_skull.instance()
		scn.position = position
		get_parent().add_child(scn)
		playing=false
		get_node("AnimationPlayer").play("die")




func getDamageOfEnemy():
	if (get_damage!=0):
		health -= get_damage
		get_damage = 0
	#Dead
	die()


func getDamageOfPlayer():
	#print("groups=",get_tree().get_nodes_in_group("enemies"))
	var bodies: Array = get_node("Area2D").get_overlapping_bodies()
	for body in bodies:
		if (body.is_in_group("enemies")):
			var direction = (position-body.position).normalized()
			var attack_direction: Vector2
			if (get_node("WarriorYellow").flip_h==true):
				attack_direction=Vector2.LEFT
			else: attack_direction=Vector2.RIGHT
			if ((direction.dot(attack_direction))<0):
				body.damage += damage_hit
			


func addLife(amount):
	var hp: int = health
	if (hp+amount>=health_max):
		hp = health_max
	else:
		hp+=amount
	return hp
