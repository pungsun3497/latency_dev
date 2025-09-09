extends State

@export var player: Player

func enter():
	player.velocity = Vector2.ZERO
	%PlayerMovement.facing = 0

func exit():
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	if not player.is_on_floor():
		return request_transition("Fall")
	if %PlayerInput.jump_input_coyote_timer > 0.0:
		return request_transition("Jump")
	if %PlayerInput.h_input != 0.0:
		return request_transition("Run")
