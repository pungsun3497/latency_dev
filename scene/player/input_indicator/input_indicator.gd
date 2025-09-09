extends Node2D
class_name InputIndicator

const ELEMENT_SCENE: PackedScene = preload("res://scene/player/input_indicator/input_indicator_element.tscn")
const SEPERATION = 5

var elements: Array[InputIndicatorElement]

func add_element(match_action: StringName):
	var element: InputIndicatorElement = ELEMENT_SCENE.instantiate()
	element.target_action = match_action
	add_child(element)
	elements.append(element)
	
	for i in elements.size():
		elements[i].position.x = SEPERATION * (i - (float(elements.size() - 1) / 2.0))


func _ready() -> void:
	add_element("move_left")
	add_element("move_right")
	add_element("jump")
	add_element("attack")
