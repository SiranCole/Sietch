extends State

class_name OnGroundState

@export var inAirState : State
@export var jumpAnimation : String = "Jump"

func _ready():
	add_to_group("PLAYER_STATES")
	
func on_enter():
	pass

func state_process(delta):
	if !character.is_on_floor():
		nextState = inAirState
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump(event)
		
func jump(event):
	character.velocity.y = -character.jumpVelocity
	nextState = inAirState
	playback.travel(jumpAnimation)

func on_exit():
	pass
