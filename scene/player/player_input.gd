extends Node
class_name PlayerInput


const JUMP_INPUT_COYOTE = 0.1


var jump_input_coyote_timer: float = 0.0
var h_input: float = 0.0


func _process(delta: float) -> void:
	h_input = DelayedInput.get_axis("move_left", "move_right")
	if DelayedInput.is_action_just_pressed("jump"):
		jump_input_coyote_timer = JUMP_INPUT_COYOTE
	elif jump_input_coyote_timer > 0.0: jump_input_coyote_timer -= delta
