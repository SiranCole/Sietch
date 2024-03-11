extends OnGroundState
class_name IdleState

@export var run_state : State

func _ready():
	add_to_group("player_states")
	
func on_enter():
	pass
	
func state_process(delta):
	super(delta)
	if character.direction.x != 0 and character.is_on_floor():
		next_state = run_state
func state_input(event : InputEvent):
	super(event)
	
func on_exit():
	pass
