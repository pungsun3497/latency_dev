extends Node
class_name StateMachine

signal state_changed(old_state_name, new_state_name)

@export var initial_state: StringName

var enabled: bool = true
var states: Dictionary
var current_state: State = null
var last_state: State = null


func _ready() -> void:
	states.clear()
	for child in get_children():
		if child is State:
			states.set(child.name, child)
	
	if initial_state.is_empty(): push_error("Needed initial state for this state machine")
	change_state(initial_state)


func get_current_state_name() -> StringName:
	if current_state: return current_state.name
	return ""


func change_state(state_name: StringName) -> void:
	if not states.has(state_name): return
	if current_state: current_state.exit()
	last_state = current_state
	current_state = states[state_name]
	if current_state: current_state.enter()
	
	state_changed.emit(last_state.name if last_state else "", current_state.name if current_state else "")


func _process(delta: float) -> void:
	if not enabled: return
	if current_state: current_state.process(delta)


func _physics_process(delta: float) -> void:
	if not enabled: return
	if current_state: current_state.physics_process(delta)
