extends CharacterBody2D
class_name Player


const GRAVITY = Global.TILE_SIZE * 40
const GROUND_COYOTE = 0.1

@export var move_speed: float = Global.TILE_SIZE * 7
@export var jump_power: float = Global.TILE_SIZE * 15

var ground_coyote_timer: float = 0
var facing: int = 1:
	set(v):
		if v > 0: facing = 1
		elif v < 0: facing = -1
var climb_facing: int = 1


func _process(delta):
	if ground_coyote_timer > 0: ground_coyote_timer -= delta

func _physics_process(delta):
	if is_on_floor(): ground_coyote_timer = GROUND_COYOTE


func is_on_floor_coyote():
	return ground_coyote_timer > 0
