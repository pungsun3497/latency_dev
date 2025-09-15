extends State

@export var player: Player

func enter():
	player.velocity = Vector2.ZERO

func exit():
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	if DelayedInput.is_action_just_pressed("attack"):
		return request_transition("Attack")
	if not player.is_on_floor():
		return request_transition("Fall")
	if player.is_on_floor_coyote() and %PlayerInput.jump_input_coyote_timer > 0.0:
		return request_transition("Jump")
	if %PlayerInput.h_input != 0.0:
		return request_transition("Run")
