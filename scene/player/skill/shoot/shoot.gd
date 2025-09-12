extends Skill

const BULLET_SCENE: PackedScene = preload("res://scene/player/skill/shoot/bullet.tscn")
@export var player: Player

func start():
	var bullet: Node2D = BULLET_SCENE.instantiate()
	bullet.position = player.position

func end():
	super()

func process(delta: float):
	pass

func physics_process(delta: float):
	pass

func _can_excuted_with_state(state_name: StringName):
	pass
