extends State

@export var entity: Enemy
var player: Player


func enter():
	player = Game.singleton.world.player
	if player == null: return request_transition("Patrol")


func exit():
	pass


func process(delta):
	pass


func physics_process(delta):
	var displacement: Vector2 = player.global_position - entity.global_position
	var angle: float = displacement.angle()
	
