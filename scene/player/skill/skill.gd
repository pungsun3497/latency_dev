extends Node2D
class_name Skill

signal skill_ended

func start():
	pass

func end():
	skill_ended.emit()

func process(delta: float):
	pass

func physics_process(delta: float):
	pass

func _can_excuted_with_state(state_name: StringName):
	pass
