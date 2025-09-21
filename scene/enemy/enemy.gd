extends CharacterBody2D
class_name Enemy

signal taked_damage(amount: int, health: int)
signal died

@export var max_health: int
@export var move_speed: float

var health: int
var facing: bool


func _ready():
	spawn()


func spawn():
	health = max_health
	facing = true


func take_damage(amount: int):
	health -= amount
	taked_damage.emit(amount, health)
	
	if health <= 0:
		_die()


func _die():
	died.emit()
