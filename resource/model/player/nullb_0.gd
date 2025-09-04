extends Node3D
class_name NullB0

const FRONT_ROTATION = 0
const FACING_ROTATION = PI/4
const CLIMBING_ROTATION = PI

var target_rotation: float

func _process(delta):
	rotation.y = lerp(rotation.y, target_rotation, delta * 20)
