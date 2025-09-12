extends Skill

@export var player: Player
var damage: int = 1

func _ready():
	disable_hitbox()

func enable_hixbox():
	$"Hitbox".monitorable = true
	$"Hitbox".monitoring = true

func disable_hitbox():
	$"Hitbox".monitorable = false
	$"Hitbox".monitoring = false

func excute():
	if not _can_excuted_with_state(%StateMachine.get_current_state_name()): return end()
	
	$"Hitbox".scale.x = player.facing
	%PlayerAnimation.play_skill("Attack")
	%PlayerAnimation.rotate_model(player.facing * PI /4)
	%StateMachine.enabled = false
	player.velocity.y = 0
	
	await skill_ended
	return

func end():
	super()
	%StateMachine.enabled = true

func process(delta: float):
	pass

func physics_process(delta: float):
	player.velocity.x = lerpf(player.velocity.x, 0, delta * 6)
	player.move_and_slide()


func _on_hitbox_area_entered(area):
	var e: Enemy = area.get_parent()
	e.take_damage(damage)

func _can_excuted_with_state(state_name: StringName):
	match state_name:
		"Idle": return true
		"Run": return true
		"Jump": return true
		"Fall": return true
	return false
