extends CanvasLayer



export var restart_delay: float = 5.0

onready var time_label: Label = get_node("BottonPanel/CenterContainer/GridContainer/LabelTSACC")
onready var monsters_label: Label = get_node("BottonPanel/CenterContainer/GridContainer/LabelMDACC")
onready var golds_label: Label = get_node("BottonPanel/CenterContainer/GridContainer/LabelGACC")
onready var meats_label: Label = get_node("BottonPanel/CenterContainer/GridContainer/LabelMACC")

onready var time_survived: String
onready var monsters_defeated: int
onready var meats: int
onready var golds: int
onready var one_time_restart = true
onready var cooldown: float = restart_delay
onready var one_time: bool = true


func updateLabels():
	
	time_label.text = time_survived
	monsters_label.text = str(monsters_defeated)
	golds_label.text = str(golds)
	meats_label.text = str(meats)



func _ready():
	updateLabels()


func _process(_delta):
	if (one_time==true):
		updateLabels()
		one_time=false
	cooldown-=_delta
	if (cooldown<=0.0):
		cooldown=restart_delay
		restartGame()
		


func restartGame():
	if (one_time_restart==true):
		GameManager.reset()
		get_tree().reload_current_scene()
		
		print("Restart the game!")
		one_time_restart=false
