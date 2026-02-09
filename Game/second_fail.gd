class_name  player_state_second_fail extends player_state

func init()->void:
	pass


func enter()->void:
	%playerStateAnime.play("fail")
	pass


func exit()->void:
	pass


func handle_inupt(event:InputEvent)->player_state:
	return next_state

func  process(_delta:float)->player_state:
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
