extends CharacterBody2D

const speed = 400
const jump_speed = -800
const garvity = 1800
var isLsatFrame = false  #是否为动画最后一帧

func _physics_process(delta: float) -> void:
		var direction = Input.get_axis("move_left","move_right")
		if is_on_floor() == false:
			velocity.y += garvity * delta
		#跳跃
		if Input.is_action_just_pressed("move_jump") and is_on_floor():
			velocity.y+=jump_speed
			velocity.x = direction * speed*2
		#角色移动
		if direction !=0:
			velocity.x = direction *speed
		else:
			velocity.x = 0
		
		#角色朝向
		if direction == -1 :
			$AnimatedSprite2D.flip_h = true
		else :
			$AnimatedSprite2D.flip_h = false
		#是否按下AD键
		var isPressedAD = (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"))
		#角色动作
		if isPressedAD  and is_on_floor():
			$AnimatedSprite2D.play("walk")
			isLsatFrame = false
		elif !is_on_floor():
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("Idie")
			isLsatFrame = false
		move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "jump":
		isLsatFrame = true
		$AnimatedSprite2D.pause()
