extends Node2D
class_name SkillManager

var skills: Dictionary
var current_skill: Skill = null

func _ready():
	for child in get_children():
		if child is Skill:
			skills.set(child.name, child)


func _process(delta):
	if DelayedInput.is_action_just_pressed("attack"):
		excute_skill("Attack")
	
	if current_skill: current_skill.process(delta)

func _physics_process(delta):
	if current_skill: current_skill.physics_process(delta)


func excute_skill(skill_name: StringName):
	if current_skill:
		return
	current_skill = skills[skill_name]
	await current_skill.excute()
	current_skill = null
	
