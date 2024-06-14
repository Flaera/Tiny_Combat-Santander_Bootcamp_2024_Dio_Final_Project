extends Node2D


export var monsters0: PackedScene
export var monsters1: PackedScene
export var monsters2: PackedScene
export var difficult_rate: float = 3.0
onready var curr_monsters_by_minute: float = 60.0
onready var monsters_by_minute: float = 60.0
onready var path_follow: PathFollow2D  = get_node("Path2D/PathFollow2D")
onready var interval: float = (curr_monsters_by_minute/monsters_by_minute) * difficult_rate
onready var monsters_array: Array
onready var random_lib = RandomNumberGenerator.new()
onready var cooldown: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	monsters_array.append(monsters0)
	monsters_array.append(monsters1)
	monsters_array.append(monsters2)
	


func _process(delta):
	cooldown+=delta
	if (cooldown>=interval):
		random_lib.randomize()
		var monster = (monsters_array[random_lib.randi_range(0,2)]).instance()
		get_parent().add_child(monster)
		#print(monster)
		
		#Check if local is no water:
		var point = getPoint()
		var world_state = get_world_2d().direct_space_state
		var result = world_state.intersect_point(point,1,[],0b1001)
		if (result.empty()==false): return
		
		
		monster.position = point
		cooldown = 0.0
	


func getPoint():
	path_follow.unit_offset = randf()
	return path_follow.position
