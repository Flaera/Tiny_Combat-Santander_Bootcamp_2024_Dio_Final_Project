extends KinematicBody2D

onready var velocity: Vector2
onready var target_velocity: Vector2
onready var is_running: bool = false
export var speed = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var input = 
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

