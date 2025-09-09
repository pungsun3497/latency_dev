extends Node
class_name PlayerAnimation

@export var player: Player
@export var movement: PlayerMovement
@export var nullb0: NullB0
@onready var anim_tree = $"../Sprite2D/SubViewport/Nullb0/AnimationTree"

func _ready() -> void:
	%PlayerMovement.state_changed.connect(on_player_movement_state_changed)
	%PlayerAttack.attacked.connect(on_player_attacked)


func on_player_movement_state_changed(old_state_name, new_state_name):
	match new_state_name:
		"Idle":
			if old_state_name == "Fall":
				anim_tree.set("parameters/LandOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			anim_tree.get("parameters/StateMachine/playback").travel("idle")
			anim_tree.get("parameters/FaceStateMachine/playback").travel("eye_blink")
		"Run":
			if old_state_name == "Fall":
				anim_tree.set("parameters/LandOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			anim_tree.get("parameters/StateMachine/playback").travel("run")
			anim_tree.get("parameters/FaceStateMachine/playback").travel("eye_blink")
		"Jump":
			anim_tree.get("parameters/StateMachine/playback").travel("fall")
			anim_tree.get("parameters/FaceStateMachine/playback").travel(">_<")
		"Fall":
			anim_tree.get("parameters/StateMachine/playback").travel("fall")
			anim_tree.get("parameters/FaceStateMachine/playback").travel("eye_blink")


func on_player_attacked():
	anim_tree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func _process(delta: float) -> void:
	rotate_model()
	anim_tree.set("parameters/StateMachine/fall/blend_position", remap(player.velocity.y, -%PlayerMovement.jump_power, %PlayerMovement.jump_power, 1, -1))


func rotate_model():
	match %PlayerMovement.get_current_state_name():
		"Idle":
			nullb0.target_rotation = 0
		"Run":
			nullb0.target_rotation = %PlayerMovement.facing * PI / 4
		"Jump":
			nullb0.target_rotation = %PlayerMovement.facing * PI / 4
		"Fall":
			nullb0.target_rotation = %PlayerMovement.facing * PI / 4
		"Climb":
			nullb0.target_rotation = %PlayerMovement.climb_facing * PI / 2
