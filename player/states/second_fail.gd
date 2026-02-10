class_name  player_state_second_fail extends player_state
# 已经实现了 二段所以不会实现土狼时间，但是会记录土狼时间实现的思路
#思路如下：
	#1.设定一个缓冲时间
	#2.当玩家进入下落状态时，只要在缓冲时间内均可以跳跃
	#代码流程： coyote_time =0.125 =>当用户按跳跃键时检测两点第一 前一个状态是否为跳跃状态 第二：是否在coyote_time时间内
@export var second_fail_gravity = 980.0*2
@export var buffer_time:float = 0.1
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
#	#跳跃优化_设置跳跃缓冲
	return next_state

func physics_process(_delta:float)->player_state:
	
	return next_state
