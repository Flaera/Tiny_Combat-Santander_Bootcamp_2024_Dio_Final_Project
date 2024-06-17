extends Node2D



onready var player: KinematicBody2D
onready var game_over_ui: PackedScene
onready var monsters_defeated_by_player: int = 0
onready var game_ui: Control = get_node("Player/GameUIControl")
onready var one_time: bool = true


func _ready():
	player = get_node("Player")
	game_over_ui = preload("res://scenes/ui/game_over_ui.tscn")


func _process(var _delta: float) -> void:
	if (get_node("Player").playing==false and one_time==true):
		triggerGameOver()
		one_time=false


func triggerGameOver():
		
	var game_over_ui_inst_scene = game_over_ui.instance()
	add_child(game_over_ui_inst_scene)
	game_over_ui_inst_scene.monsters_defeated = monsters_defeated_by_player
	game_over_ui_inst_scene.meats = player.meats
	#print("plmeats=",game_over_ui_inst_scene.meats)
	game_over_ui_inst_scene.golds = player.golds
	game_over_ui_inst_scene.time_survived = player.time_game
	print("")
	
	
	#game_ui.queue_free()
	game_ui=null



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#print("POs=",get_node("Player/MobSpawner").position)
	#print("POsPlayer=",get_node("Player").position)
	
	
	
