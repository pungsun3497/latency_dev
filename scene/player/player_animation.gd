extends Node
class_name PlayerAnimation

@export var player: Player
@export var movement: PlayerMovement
@export var nullb0: NullB0
@onready var anim_tree = $"../Sprite2D/SubViewport/Nullb0/AnimationTree"

func _process(delta: float) -> void:
	set_animation()

func set_animation() -> void:
	if movement.is_climbing and not movement.is_climbing_high:
		#print_debug("A")
		anim_tree.set("parameters/climb_high_transition/transition_request", "no_high")
		anim_tree.set("parameters/climb_transition/transition_request", "climb")
		if movement.is_just_climbed:
			anim_tree.tree_root.get_node("climb_direction_transition").xfade_time = 0.0
			anim_tree.set("parameters/climb_in_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			nullb0.target_rotation = nullb0.CLIMBING_ROTATION * movement.climb_facing
		else:
			anim_tree.tree_root.get_node("climb_direction_transition").xfade_time = 0.4
		if movement.climb_facing == movement.facing:
			anim_tree.set("parameters/climb_direction_transition/transition_request", "front")
		else:
			anim_tree.set("parameters/climb_in_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
			anim_tree.set("parameters/climb_direction_transition/transition_request", "other_side")
			if movement.facing > 0:
				anim_tree.set("parameters/climb_other_side_left_right_transition/transition_request", "left")
			else:
				anim_tree.set("parameters/climb_other_side_left_right_transition/transition_request", "right")
	elif movement.is_climbing and movement.is_climbing_high:
		anim_tree.set("parameters/climb_high_transition/transition_request", "high")
		anim_tree.set("parameters/climb_transition/transition_request", "climb")
		if movement.is_just_climbed:
			anim_tree.tree_root.get_node("ch_direction_transition").xfade_time = 0.0
			anim_tree.set("parameters/ch_in_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			nullb0.target_rotation = nullb0.CLIMBING_ROTATION * movement.climb_facing
		else:
			anim_tree.tree_root.get_node("ch_direction_transition").xfade_time = 0.4
		if movement.climb_facing == movement.facing:
			anim_tree.set("parameters/ch_direction_transition/transition_request", "front")
		else:
			anim_tree.set("parameters/ch_in_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
			anim_tree.set("parameters/ch_direction_transition/transition_request", "other_side")
			if movement.facing > 0:
				anim_tree.set("parameters/ch_other_side_left_right_transition/transition_request", "left")
			else:
				anim_tree.set("parameters/ch_other_side_left_right_transition/transition_request", "right")
	else:
		anim_tree.set("parameters/climb_transition/transition_request", "no_climb")
		nullb0.target_rotation = nullb0.FACING_ROTATION * movement.facing
	
	if movement.is_dashing:
		anim_tree.set("parameters/dash_transition/transition_request", "dashing")
	else:
		anim_tree.set("parameters/dash_transition/transition_request", "no_dashing")
	
	if player.is_on_floor():
		anim_tree.set("parameters/ground_transition/transition_request", "ground")
		if movement.is_just_landed == true:
			anim_tree.set("parameters/land_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	else:
		anim_tree.set("parameters/ground_transition/transition_request", "float")
	
	anim_tree.set("parameters/run_blend/blend_amount", abs(movement.h_input))
	if abs(movement.h_input) > 0 and abs(player.velocity.x / player.TILE_SIZE) < 0.1:
		anim_tree.set("parameters/face_transition/transition_request", "uwu")
	elif player.velocity.y < 0:
		anim_tree.set("parameters/face_transition/transition_request", "uwu")
	else:
		anim_tree.set("parameters/face_transition/transition_request", "blink")
	anim_tree.set("parameters/jump_blend/blend_amount", clampf(player.velocity.y/movement.jump_power/2 + 0.5, 0, 1))
