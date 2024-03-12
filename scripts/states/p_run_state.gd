extends OnGroundState
class_name RunState

@export var idleState : State

func _ready():
	add_to_group("PLAYER_STATES")
	
func on_enter():
	pass
	
func state_process(delta):
	super(delta)
	if character.direction.x == 0 and character.is_on_floor():
		nextState = idleState
func state_input(event : InputEvent):
	super(event)

func on_exit():
	pass
