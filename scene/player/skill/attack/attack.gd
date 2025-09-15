extends Skill

@export var player: Player
var damage: int = 1

func _ready():
	$AnimatedSprite2D.play("default")

func excute():
	super()
	
	scale.x = player.facing
	%PlayerAnimation.play_skill("Attack")
	%PlayerAnimation.rotate_model(player.facing * PI /4)
	$AnimatedSprite2D.play("attack")

func end():
	super()

func process(delta: float):
	pass

func physics_process(delta: float):
	pass


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
