extends Enemy

func _process(delta):
	$"Label".text = str(health)
