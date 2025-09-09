extends Node
class_name State

func enter():
	pass

func exit():
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	pass

func request_transition(state: StringName):
	if get_parent() is StateMachine:
		get_parent().change_state(state)
