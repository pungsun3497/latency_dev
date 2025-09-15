extends Node
class_name PlayerAnimation

@export var player: Player
@export var nullb0: NullB0
@onready var anim_tree = $"../Sprite2D/SubViewport/Nullb0/AnimationTree"

func _ready() -> void:
	%StateMachine.state_changed.connect(on_state_changed)


func on_state_changed(old_state_name, new_state_name):
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
	


func _process(delta: float) -> void:
	anim_tree.set("parameters/StateMachine/fall/blend_position", remap(player.velocity.y, -player.jump_power, player.jump_power, 1, -1))


func rotate_model(angle):
	nullb0.target_rotation = angle


func play_skill(skill_name: StringName):
	match skill_name:
		"Attack":
			anim_tree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		"Dash":
			anim_tree.set("parameters/RollOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
