extends State

class_name LandingState

@export var landingAnimationName : String = "landing"
@export var idleState: State

func _ready():
	add_to_group("PLAYER_STATES")

func on_enter():
	pass
	
func on_exit():
	pass

func _on_animation_tree_animation_finished(animName):
	if animName == landingAnimationName:
		nextState = idleState
