extends Node
class_name PlayerAttack

signal attacked


func _process(delta: float) -> void:
	if DelayedInput.is_action_just_pressed("attack"):
		attack()


func attack():
	attacked.emit()
