extends Control



onready var minutes: int = 0
onready var seconds: int = 0
onready var hours: int = 0
onready var time_elapsed: float = 0.0
onready var time_elapsed_by_sec: float = 0.0
onready var meats: int = 0
onready var golds: int = 0



func _process(delta):
	time_elapsed+=delta # time total in seconds
	time_elapsed_by_sec+=delta
	seconds=int(time_elapsed_by_sec)
	if (seconds%60==0 and seconds!=0):
		minutes+=1
		seconds=0
	if (minutes%60==0 and minutes!=0):
		hours+=1
		minutes = 0

	get_node("CanvasLayer/Label").text= "%2d:%02d:%02d" % [hours, minutes, seconds]
	get_node("CanvasLayer/Control/GoldLabel").text = str(golds)
	get_node("CanvasLayer/Control/MeatLabel").text = str(meats)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
