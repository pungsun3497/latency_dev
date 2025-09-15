extends Node2D
class_name Skill

@export var duration: float = 0.3

signal skill_ended

func excute():
	if not _can_excuted_with_state(%StateMachine.get_current_state_name()): return end()
	await get_tree().create_timer(duration).timeout
	end()
	return

func end():
	skill_ended.emit()

func process(delta: float):
	pass

func physics_process(delta: float):
	pass

func _can_excuted_with_state(state_name: StringName):
	pass
