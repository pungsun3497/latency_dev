extends Line2D
class_name InputIndicatorLine

var current_time: float = 0.0
var released_time: float = 0.0
var is_released: bool = false
var target_action: StringName = ""
var p1: float = 0.0
var p2: float = 0.0

func _ready() -> void:
	add_point(Vector2(0, 0))
	add_point(Vector2(0, 0))

func _process(delta: float) -> void:
	current_time += delta
	if not is_released and Input.is_action_just_released(target_action): 
		is_released = true
		released_time = current_time
	
	p1 = clamp(current_time / DelayedInput.delay, 0, 1)
	p2 = clamp((current_time - released_time) / DelayedInput.delay, 0, 1) if is_released else 0
	
	set_point_position(0, Vector2(0, -get_parent().length * (1 - p1)))
	set_point_position(1, Vector2(0, -get_parent().length * (1 - p2)))
	
	if is_released and current_time - released_time > DelayedInput.delay:
		queue_free()
