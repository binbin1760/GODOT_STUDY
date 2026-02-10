class_name Player extends CharacterBody2D


var states:Array[player_state]
var current_state:player_state:
	get:return states.front()
var previous_state:player_state:
	get: return states[1]

var direction:Vector2 = Vector2.ZERO
var gravity:float = 980.0
var gravity_multiplier:float = 1.0

func _ready() -> void:
	initialize_states()
	update_direction()
	pass

func _unhandled_input(event: InputEvent) -> void:
	# 角色朝向控制
	if event.is_action_pressed("move_left"):
		%playerStateAnime.flip_h = true
	elif event.is_action_pressed("move_right"):
		$playerStateAnime.flip_h = false
	change_state(current_state.handle_inupt(event))
	pass

func _process(delta: float) -> void:
	update_direction()
	change_state(current_state.process(delta))
	pass

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta* gravity_multiplier
	# move_and_slide 存在一个局限性即当我贴在墙边进行跳跃时，左跳，又跳 会出现X方向的速度被重置为0的情况
	# 当X轴的速度被重置为0时就会出现原地跳跃的现象
	move_and_slide()
	change_state(current_state.physics_process(delta))
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
	var direct_x = Input.get_axis("move_left","move_right")
	var direct_y = Input.get_axis("move_up","move_down")
	direction.x = direct_x
	direction.y = direct_y
