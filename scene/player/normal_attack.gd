extends State

@export var player: Player

const DELAY = 0.3


func enter():
	await get_tree().create_timer(DELAY).timeout
	
	if player.is_on_floor():
		if %PlayerInput.h_input == 0.0:
			return request_transition("Idle")
		else:
			return request_transition("Run")
	else:
		return request_transition("Fall")

func exit():
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	pass
