class_name  player_state extends Node
 
var player:Player
var next_state:player_state = null

@onready var idle: player_state_idle = %Idle
@onready var walk: player_state_walk = %walk
@onready var jump: player_state_jump = %jump
@onready var second_jump: player_state_second_jump = %second_jump
@onready var run: player_state_run = %run
@onready var fail: player_state_fail = %fail
@onready var second_fail: player_state_second_fail = %second_fail

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
