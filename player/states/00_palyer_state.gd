class_name  player_state extends Node
 
var player:Player
var next_state:player_state = null

func init()->void:
	pass


func enter()->void:
	pass


func exit()->void:
	pass


func handle_inupt(event:InputEvent)->player_state:
	return next_state

func  process(_delta:float)->player_state:
	return next_state

func physics_process(_delta:float)->player_state:
	return next_state
