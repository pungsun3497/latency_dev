extends State

@export var player: Player

func enter():
	player.velocity.y = 0

func exit():
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	player.velocity.x = %PlayerInput.h_input * player.move_speed
	player.move_and_slide()
	player.facing = %PlayerInput.h_input
	%PlayerAnimation.rotate_model(player.facing * PI / 4)
	
	if DelayedInput.is_action_just_pressed("attack"):
		return request_transition("Attack")
	if not player.is_on_floor():
		return request_transition("Fall")
	if player.is_on_floor_coyote() and %PlayerInput.jump_input_coyote_timer > 0.0:
		return request_transition("Jump")
	if %PlayerInput.h_input == 0.0:
		return request_transition("Idle")
