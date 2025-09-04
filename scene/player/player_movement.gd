extends Node
class_name PlayerMovement

const JUMP_INPUT_COYOTE = 0.1
const GRAVITY = player.TILE_SIZE * 25

@export var player: Player
@export var move_speed: float = player.TILE_SIZE * 5
@export var jump_power: float = player.TILE_SIZE * 12

var h_input: float
var jump_input_coyote_timer: float

var is_climbing: bool = false
var is_climbing_high :bool = false
var is_just_climbed: bool = false
var climb_facing: int = 1
var facing: int = 0
var is_dashing: bool = false
var is_just_landed: bool = false
var is_just_jumped: bool = false
var is_floating: bool = false

func _process(delta: float) -> void:
	h_input = DelayedInput.get_axis("move_left", "move_right")
	facing = h_input
	if DelayedInput.is_action_just_pressed("jump"):
		jump_input_coyote_timer = JUMP_INPUT_COYOTE
	jump_input_coyote_timer -= delta

func _physics_process(delta: float) -> void:
	is_just_climbed = false
	is_just_jumped = false
	is_just_landed = false
	
	player.velocity.x = h_input * move_speed
	facing = h_input
	
	if player.is_on_floor():
		if is_floating:
			land()
		if jump_input_coyote_timer > 0.0:
			jump()
	else:
		player.velocity.y += GRAVITY * delta
		is_floating = true
	
	player.move_and_slide()


func jump():
	player.velocity.y -= jump_power
	is_just_jumped = true
	jump_input_coyote_timer = 0.0


func land():
	player.velocity.y = 0
	is_just_landed = true
	is_floating = false
