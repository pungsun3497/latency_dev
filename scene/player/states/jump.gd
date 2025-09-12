extends State

@export var player: Player

func enter():
	player.velocity.y = -player.jump_power
	%PlayerInput.jump_input_coyote_timer = 0.0
	player.facing = %PlayerInput.h_input

func exit():
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	player.velocity.x = %PlayerInput.h_input * player.move_speed
	player.velocity.y += player.GRAVITY * delta
	player.move_and_slide()
	player.facing = %PlayerInput.h_input
	%PlayerAnimation.rotate_model(player.facing * PI / 4 if %PlayerInput.h_input != 0 else 0)
	
	if player.is_on_floor():
		if %PlayerInput.h_input == 0.0: return request_transition("Idle")
		else: return request_transition("Run")
	if player.velocity.y > 0.0:
		return request_transition("Fall")
