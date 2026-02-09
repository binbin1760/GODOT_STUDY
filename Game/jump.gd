class_name  player_state_jump extends player_state

@export var jump_speed:float = 600.0

func init()->void:
	pass


func enter()->void:
	%playerStateAnime.play("jump")
	player.velocity.y = -jump_speed
	pass


func exit()->void:
	pass


func handle_inupt(event:InputEvent)->player_state:
	#处理跳跃在空中时，按下左右移动的情况
	# 01在左右跳跃时处理下按下左右反方向键的情况
	if event.is_action_pressed("move_left") and player.velocity.x >0:
		player.velocity.x = player.velocity.x*-1
	if event.is_action_pressed("move_right") and player.velocity.x < 0:
		player.velocity.x = player.velocity.x*-1
	# 02 处理空中左右朝向问题
	if not player.is_on_floor():
		var new_direct = Input.get_axis("move_left","move_right")
		player.velocity.x = %run.run_in_hair * new_direct
	if not player.is_on_floor() and event.is_action_pressed("move_jump"):
		%playerStateAnime.stop()
		return second_jump		
	return next_state

func  process(_delta:float)->player_state:	
	return next_state

func physics_process(_delta:float)->player_state:
	if player.velocity.y >=0:
		return fail
	return next_state
