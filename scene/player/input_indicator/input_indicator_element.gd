extends Node2D
class_name InputIndicatorElement

const LINE_SCENE: PackedScene = preload("res://scene/player/input_indicator/input_indicator_line.tscn")

var length = 30
var target_action: StringName
var is_starting: bool = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed(target_action): start_line()


func start_line():
	var line: InputIndicatorLine = LINE_SCENE.instantiate()
	line.target_action = target_action
	add_child(line)
