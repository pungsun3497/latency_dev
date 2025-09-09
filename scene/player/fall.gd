extends State

@export var player: Player

func enter():
	pass

func exit():
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	player.velocity.x = %PlayerInput.h_input * %PlayerMovement.move_speed
	player.velocity.y += %PlayerMovement.GRAVITY * delta
	player.move_and_slide()
	%PlayerMovement.facing = %PlayerInput.h_input
	
	if player.is_on_floor():
		if %PlayerInput.h_input == 0.0: return request_transition("Idle")
		else: return request_transition("Run")
	#if input.jump_input_coyote_timer > 0.0:
		#return request_transition("Jump")
