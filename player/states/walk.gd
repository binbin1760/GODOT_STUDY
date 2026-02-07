class_name  player_state_walk extends player_state
 
func init()->void:
	pass


func enter()->void:
	print("节点名称：",name)
	pass


func exit()->void:
	pass


func handle_inupt(event:InputEvent)->player_state:
	return next_state

func  process(_delta:float)->player_state:
	return next_state

func physics_process(_delta:float)->player_state:
	return next_state
