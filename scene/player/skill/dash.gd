extends Skill

@export var player: Player

var speed: float = Global.TILE_SIZE * 20

func excute():
	super()
	%PlayerAnimation.rotate_model(player.facing * PI /2)
	%PlayerAnimation.play_skill("Dash")
	%StateMachine.enabled = false
	player.velocity.x = player.facing * speed
	player.velocity.y = 0

func end():
	super()
	%StateMachine.enabled = true

func process(delta: float):
	pass

func physics_process(delta: float):
	#player.velocity.x = lerp(player.velocity.x, player.move_speed * player.facing, delta * 6)
	player.move_and_slide()

func _can_excuted_with_state(state_name: StringName):
	match state_name:
		"Idle": return true
		"Run": return true
		"Jump": return true
		"Fall": return true
