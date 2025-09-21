@abstract
extends Node
class_name State

@abstract
func enter()

@abstract
func exit()

@abstract
func process(delta: float)

@abstract
func physics_process(delta: float)

func request_transition(state: StringName):
	if get_parent() is StateMachine:
		get_parent().change_state(state)
