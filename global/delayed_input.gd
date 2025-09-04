extends Node


signal unhandled_delayed_input(event: InputEvent)


class TimedInputEvent:
	var time: float = 0
	var event: InputEvent
	func _init(time: float = 0.0, event: InputEvent = null):
		self.time = time
		self.event = event


var delay: float = 0.5
var input_stream: Array[TimedInputEvent]
var action_status: Dictionary
var current_time: float = 0.0


func _init():
	unhandled_delayed_input.connect(_unhandled_delayed_input)
	
	for action in InputMap.get_actions():
		action_status.set(action, ActionStatus.new())


func _unhandled_input(event):
	input_stream.push_back(TimedInputEvent.new(current_time, event))


func _process(delta):
	current_time += delta
	
	while not input_stream.is_empty():
		var f: TimedInputEvent = input_stream.front()
		if f.time + delay <= current_time:
			unhandled_delayed_input.emit(f.event)
			input_stream.pop_front()
		else:
			break


func _unhandled_delayed_input(event: InputEvent):
	parse_input_event(event)


func parse_input_event(event: InputEvent):
	for action in InputMap.get_actions():
		if event.is_action(action):
			action_status[action].pressed = event.is_pressed()
			action_status[action].strength = 0.0
			if not event.is_echo():
				if event.is_pressed(): 
					action_status[action].process_pressed_frame = Engine.get_process_frames()
					action_status[action].physics_pressed_frame = Engine.get_physics_frames() + 1
				else:
					action_status[action].process_released_frame = Engine.get_process_frames()
					action_status[action].physics_released_frame = Engine.get_physics_frames() + 1


func is_action_pressed(action: StringName):
	var s: ActionStatus = action_status.get(action)
	if not s:
		return false
	return s.pressed


func is_action_just_pressed(action: StringName):
	var s: ActionStatus = action_status.get(action)
	if not s or not s.pressed:
		return false
	if Engine.is_in_physics_frame():
		print_debug(s.physics_pressed_frame, " : ", Engine.get_physics_frames())
		return s.physics_pressed_frame == Engine.get_physics_frames()
	else:
		return s.process_pressed_frame == Engine.get_process_frames()


func is_action_just_released(action: StringName):
	var s: ActionStatus = action_status.get(action)
	if not s or s.pressed:
		return false
	if Engine.is_in_physics_frame():
		return s.physics_released_frame == Engine.get_physics_frames()
	else:
		return s.process_released_frame == Engine.get_process_frames()


func get_axis(negative_action: StringName, positive_action: StringName) -> float:
	var axis: float = 0.0
	if action_status[negative_action].pressed: axis -= 1
	if action_status[positive_action].pressed: axis += 1
	return axis
