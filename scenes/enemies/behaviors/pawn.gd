extends KinematicBody2D

onready var velocity: Vector2
onready var is_running: bool = false
onready var player: Object = get_node("/root/Node2D/Player")
onready var cooldown: float = 0.0
onready var play_cooldown: bool = false
onready var damage: int = 0
onready var scene_skull: PackedScene = preload("res://scenes/skull/skull.tscn")
onready var player_position: Vector2 = player.position
onready var damage_digit_scene: PackedScene = preload("res://scenes/enemies/damage_digit.tscn")
onready var drop_meat: PackedScene = preload("res://scenes/meat/meat.tscn")
onready var drop_gold: PackedScene = preload("res://scenes/gold/gold.tscn")
onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
export var health = 10
export var speed: float = 1
export var damage_hit: int = 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	player_position = player.position
	var normal = (player_position - position).normalized()
	var target_velocity: Vector2 = normal*speed*100.0
	velocity = lerp(velocity, target_velocity, 0.05)
	move_and_slide(velocity, Vector2.UP, true)
	get_node("AnimatedSprite").play("default")

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
		var damage_digit_marker = get_node("Position2D")
		var scene_damage_instance = damage_digit_scene.instance()
		scene_damage_instance.damage_value = int(damage)
		add_child(scene_damage_instance)
		health -= damage
		#print("damage=",damage)
		
		modulate = Color.red
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(self,"modulate",Color.white,1.5)
		
		damage = 0

	# Dead:
	if (health<=0):
		#Drop skull
		var scn: Object = scene_skull.instance()
		scn.position = position
		get_parent().add_child(scn)
		#Drops colletables:
		rng.randomize()
		if (randi()%2==0):
			var scene_drop_meat_instance = drop_meat.instance()
			scene_drop_meat_instance.position = position
			get_parent().add_child(scene_drop_meat_instance)
		else:
			var scene_drop_gold_instance = drop_gold.instance()
			scene_drop_gold_instance.position = position
			get_parent().add_child(scene_drop_gold_instance)
		
		queue_free()
