extends Node
class_name StateMachine

@export var initial_state: StringName

var states: Dictionary
var current_state: State = null


func _ready() -> void:
	states.clear()
	for child in get_children():
		if child is State:
			states.set(child.name, child)
	change_state(initial_state)


func change_state(state_name: StringName) -> void:
	if not states.has(state_name): return
	if current_state: current_state._exit()
	current_state = states[state_name]
	if current_state: current_state._enter()


func _process(delta: float) -> void:
	if current_state: current_state._process(delta)


func _physics_process(delta: float) -> void:
	if current_state: current_state._physics_process(delta)
