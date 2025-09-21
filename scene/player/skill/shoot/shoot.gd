extends Skill

const BULLET_SCENE: PackedScene = preload("uid://rbwmc6g5gvhs")
@export var player: Player

func excute():
	super()
	var bullet: Node2D = BULLET_SCENE.instantiate()
	bullet.position = player.position
	player.get_parent().add_child(bullet)

func end():
	super()

func process(delta: float):
	pass

func physics_process(delta: float):
	pass

func _can_excuted_with_state(state_name: StringName):
	return true
