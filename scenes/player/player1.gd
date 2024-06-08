extends KinematicBody2D

export var speed: float = 5
export var health: int = 10
export onready var damage_hit: int = 4
onready var velocity: Vector2
onready var is_running: bool = false
onready var get_damage: int = 0
onready var input: Vector2 = Vector2(0.0,0.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
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
		
	if (Input.is_action_just_pressed("ui_accept") and input.is_equal_approx(Vector2(0.0,0.0))):
		get_node("AnimationPlayer").play("attack0")

	getDamageOfEnemy()
	print("hp=",health)


func getDamageOfEnemy():
	if (get_damage!=0):
		health -= get_damage
		get_damage = 0


func getDamageOfPlayer():
	#print("groups=",get_tree().get_nodes_in_group("enemies"))
	var bodies: Array = get_node("Area2D").get_overlapping_bodies()
	for body in bodies:
		for enemy in get_tree().get_nodes_in_group("enemies"):
			if (body.name in enemy.name):
				enemy.damage += damage_hit
