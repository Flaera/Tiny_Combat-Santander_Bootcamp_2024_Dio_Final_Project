extends Node


var is_game_over: bool = false


func endGame():
	if (is_game_over==true):
		return
		
	is_game_over=true


func reset():
	is_game_over=false
	
