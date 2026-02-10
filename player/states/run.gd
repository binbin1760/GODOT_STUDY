class_name  player_state_run extends player_state
 
@export var run_speed:float = 400
@export var run_in_hair:float = 300

func init()->void:
	pass


func enter()->void:
	%playerStateAnime.play("run")
	pass


func exit()->void:
	pass


func handle_inupt(event:InputEvent)->player_state:
	if event.is_action_pressed("move_jump") and player.is_on_floor():
		return jump
	return next_state

func  process(_delta:float)->player_state:
	#这里有个问题，如果我在移动状态中疯狂左右键，就会让player进入idle状态
	if player.direction.x == 0:
		return idle
	return next_state
func physics_process(_delta:float)->player_state:
	player.velocity.x = run_speed*player.direction.x
	if not player.is_on_floor():
		return fail
	return next_state
