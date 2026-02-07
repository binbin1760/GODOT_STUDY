class_name Player extends CharacterBody2D


var states:Array[player_state]
var current_state:player_state:
	get:return states.front()
var previous_state:player_state:
	get: return states[1]

var direction:Vector2 = Vector2.ZERO
var gravity:float = 980

func _ready() -> void:
	initialize_states()
	update_direction()
	pass

func _process(delta: float) -> void:
	change_state(current_state.process(delta))
	pass

func _physics_process(delta: float) -> void:
	pass	

func initialize_states()->void:
	states = []
	for StatesSunNode in $States.get_children():
		if StatesSunNode is player_state:
			states.append(StatesSunNode)
			StatesSunNode.player = self
	
	if states.size() == 0:
		return
	
	for state in states:
		state.init()
	#初始化其实状态
	current_state.enter()
	change_state(current_state)

func change_state(new_state:player_state)->void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	if current_state:
		current_state.exit()
	states.push_front(new_state)
	current_state.enter()
	states.resize(3)
	pass

func update_direction()->void:
	var prev_direction:Vector2 = direction
	direction = Input.get_vector("move_left","move_right",'move_up','move_down')
