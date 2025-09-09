extends StateMachine
class_name PlayerMovement

const GRAVITY = player.TILE_SIZE * 25
const JUMP_GROUND_COYOTE = 0.1

@export var player: Player
@export var move_speed: float = player.TILE_SIZE * 5
@export var jump_power: float = player.TILE_SIZE * 12

var jump_ground_coyote_timer: float = 0.0
var facing: int = 0:
	set(v):
		if v > 0: facing = 1
		elif v < 0: facing = -1
		else: facing = 0
var climb_facing: int = 1

func _process(delta: float) -> void:
	if jump_ground_coyote_timer > 0.0: jump_ground_coyote_timer -= delta

func get_current_state_name() -> StringName:
	if current_state: return current_state.name
	return ""
