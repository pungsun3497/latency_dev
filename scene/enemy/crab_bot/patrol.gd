extends State

func enter():
	$"../..".velocity.x = $"../..".move_speed
	if randi() & 1: flip()

func exit():
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	if %FrontRay.is_colliding() or not %FrontFloorRay.is_colliding():
		flip()
	if $"../..".is_on_floor(): $"../..".velocity.y = 0
	else: $"../..".velocity.y += Global.TILE_SIZE * 24 * delta
	
	$"../..".move_and_slide()

func flip():
	$"../..".velocity.x *= -1
	$"../../RayPivot".scale.x *= -1
