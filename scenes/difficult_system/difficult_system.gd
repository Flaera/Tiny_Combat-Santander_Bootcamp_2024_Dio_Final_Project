extends Node


export var initial_spawn_rate: float = 60.0
export var spawn_rate_by_minute: float = 3.0
export var wave_duration: float = 20.0
#export var break_intensity: float = 0.5
export var break_into_waves: float = 60.0
export var time_wave: float = 20.0
export var time_break: float = 40.0
export var difficult_delta: float = 3
export var acc_diff_delta: float = difficult_delta

onready var mob_spawner: MobSpawner = get_parent().get_node("MobSpawner")
onready var time: float = 0.0
onready var wave_state: int = 0 # 0 in wave, 1 in pause




func _process(delta):
	if (GameManager.is_game_over):return
	
	time += delta
	
	"""
	#Linear dificulty:
	var spawn_rate: float = initial_spawn_rate+spawn_rate_by_minute*(time/60.0)
	#Senoind dificulty:
	var sin_wave: float = sin((TAU*time)/wave_duration)
	#var wave_factor = remap(sin_wave,-1.0,1.0, break_intensity, 1)
	spawn_rate *= sin_wave
	#print("SP=",spawn_rate)
	mob_spawner.difficult_rate = spawn_rate
	"""
	
	#print("mob=",mob_spawner.difficult_rate, "wave=",wave_state)
	#print("time:", time)
	if (time>=time_wave and wave_state==0):
		acc_diff_delta+=difficult_delta
		mob_spawner.difficult_rate=acc_diff_delta
		time = 0.0
		wave_state = 1
	if (time>=time_break and wave_state==1):
		mob_spawner.difficult_rate = 1
		time = 0.0
		wave_state = 0
	
