extends Node
class_name PlayerAttack

signal attacked

var attack_facing: int


func _process(delta: float) -> void:
	if DelayedInput.is_action_just_pressed("attack"):
		attack()
	
	if %PlayerMovement.facing != 0: attack_facing = %PlayerMovement.facing


func attack():
	attacked.emit()
