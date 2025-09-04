extends CharacterBody2D
class_name Player

const TILE_SIZE = 64
const GRAVITY = TILE_SIZE * 25
const JUMP_INPUT_COYOTE = 0.1

@export var move_speed: float = TILE_SIZE * 5
@export var jump_power: float = TILE_SIZE * 12
@onready var anim_tree: AnimationTree = $"Sprite2D/SubViewport/Nullb0/AnimationTree"
@export var nullb0: NullB0

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

func _process(delta):
	h_input = DelayedInput.get_axis("move_left", "move_right")
	facing = h_input
	if DelayedInput.is_action_just_pressed("jump"):
		jump_input_coyote_timer = JUMP_INPUT_COYOTE
	jump_input_coyote_timer -= delta
	
	set_animation()

func _physics_process(delta):
	velocity.x = h_input * move_speed
	
	if is_on_floor():
		velocity.y = 0
		if jump_input_coyote_timer > 0.0:
			velocity.y -= jump_power
			jump_input_coyote_timer = 0.0
	else:
		velocity.y += GRAVITY * delta
	
	move_and_slide()


func set_animation() -> void:
	if is_climbing and not is_climbing_high:
		#print_debug("A")
		anim_tree.set("parameters/climb_high_transition/transition_request", "no_high")
		anim_tree.set("parameters/climb_transition/transition_request", "climb")
		if is_just_climbed:
			anim_tree.tree_root.get_node("climb_direction_transition").xfade_time = 0.0
			anim_tree.set("parameters/climb_in_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			nullb0.target_rotation = nullb0.CLIMBING_ROTATION * climb_facing
		else:
			anim_tree.tree_root.get_node("climb_direction_transition").xfade_time = 0.4
		if climb_facing == facing:
			anim_tree.set("parameters/climb_direction_transition/transition_request", "front")
		else:
			anim_tree.set("parameters/climb_in_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
			anim_tree.set("parameters/climb_direction_transition/transition_request", "other_side")
			if facing > 0:
				anim_tree.set("parameters/climb_other_side_left_right_transition/transition_request", "left")
			else:
				anim_tree.set("parameters/climb_other_side_left_right_transition/transition_request", "right")
	elif is_climbing and is_climbing_high:
		anim_tree.set("parameters/climb_high_transition/transition_request", "high")
		anim_tree.set("parameters/climb_transition/transition_request", "climb")
		if is_just_climbed:
			anim_tree.tree_root.get_node("ch_direction_transition").xfade_time = 0.0
			anim_tree.set("parameters/ch_in_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			nullb0.target_rotation = nullb0.CLIMBING_ROTATION * climb_facing
		else:
			anim_tree.tree_root.get_node("ch_direction_transition").xfade_time = 0.4
		if climb_facing == facing:
			anim_tree.set("parameters/ch_direction_transition/transition_request", "front")
		else:
			anim_tree.set("parameters/ch_in_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
			anim_tree.set("parameters/ch_direction_transition/transition_request", "other_side")
			if facing > 0:
				anim_tree.set("parameters/ch_other_side_left_right_transition/transition_request", "left")
			else:
				anim_tree.set("parameters/ch_other_side_left_right_transition/transition_request", "right")
	else:
		anim_tree.set("parameters/climb_transition/transition_request", "no_climb")
		nullb0.target_rotation = nullb0.FACING_ROTATION * facing
	
	if is_dashing:
		anim_tree.set("parameters/dash_transition/transition_request", "dashing")
	else:
		anim_tree.set("parameters/dash_transition/transition_request", "no_dashing")
	
	if is_on_floor():
		anim_tree.set("parameters/ground_transition/transition_request", "ground")
		if is_just_landed == true:
			anim_tree.set("parameters/land_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	else:
		anim_tree.set("parameters/ground_transition/transition_request", "float")
	
	
	var h_input : float = 0.0
	if DelayedInput.is_action_pressed("move_left"): h_input -= 1.0
	if DelayedInput.is_action_pressed("move_right"): h_input += 1.0
	
	anim_tree.set("parameters/run_blend/blend_amount", abs(h_input))
	if abs(h_input) > 0 and abs(velocity.x / TILE_SIZE) < 0.1:
		anim_tree.set("parameters/face_transition/transition_request", "uwu")
	elif velocity.y < 0:
		anim_tree.set("parameters/face_transition/transition_request", "uwu")
	else:
		anim_tree.set("parameters/face_transition/transition_request", "blink")
	anim_tree.set("parameters/jump_blend/blend_amount", clampf(-velocity.y/jump_power/2 + 0.5, 0, 1))
	
	
	#if is_just_jumped:
		#scale_effector.stretch()
