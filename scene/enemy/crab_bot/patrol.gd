extends State

@export var entity: CharacterBody2D
const MAX_DETACT_RANGE = Global.TILE_SIZE * 10

func enter():
	entity.velocity.x = entity.move_speed
	if randi() & 1: flip()

func exit():
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	if %FrontRay.is_colliding() or not %FrontFloorRay.is_colliding():
		flip()
	if entity.is_on_floor(): entity.velocity.y = 0
	else: entity.velocity.y += Global.TILE_SIZE * 24 * delta
	
	entity.move_and_slide()
	
	# Detact Player
	var player: Player = Game.singleton.world.player
	if player == null: return
	if entity.global_position.distance_to(player.global_position) > MAX_DETACT_RANGE: return
	%PlayerRay.target_position = player.global_position - entity.global_position
	%PlayerRay.force_raycast_update()
	if %PlayerRay.is_colliding() and %PlayerRay.get_collider() is Player:
		request_transition("Follow")


func flip():
	entity.velocity.x *= -1
	%"RayPivot".scale.x *= -1
