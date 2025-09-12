extends Area2D

var speed: float = Global.TILE_SIZE * 10

func _process(delta):
	position = position + transform.x * speed * delta
