class_name  player_state_fail extends player_state

func init()->void:
	pass


func enter()->void:
	%playerStateAnime.play("fail")
	player.gravity_multiplier = 1.25
	pass


func exit()->void:
	player.gravity_multiplier = 1.0
	pass


func handle_inupt(event:InputEvent)->player_state:
	if not player.is_on_floor() and event.is_action_pressed("move_jump"):
		return second_jump
	return next_state

func  process(_delta:float)->player_state:
	#处理跳跃在空中时，按下左右移动的情况
	# 01在左右跳跃时处理下按下左右反方向键的情况
	if Input.is_action_pressed("move_left") and player.velocity.x >0:
		player.velocity.x = player.velocity.x*-1
	if Input.is_action_pressed("move_right") and player.velocity.x < 0:
		player.velocity.x = player.velocity.x*-1
	# 02 处理空中左右朝向问题
	if not player.is_on_floor():
		var new_direct = Input.get_axis("move_left","move_right")
		player.velocity.x = %run.run_in_hair * new_direct
	
	if player.is_on_floor() and player.velocity.x == 0:
		return idle	
	if player.is_on_floor() and player.velocity.x !=0:
		return run	
	return next_state

func physics_process(_delta:float)->player_state:
	return next_state
