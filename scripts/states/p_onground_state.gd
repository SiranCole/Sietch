extends State

class_name OnGroundState

@export var inair_state : State
@export var jump_animation : String = "Jump"

func _ready():
	add_to_group("player_states")
	
func on_enter():
	pass

func state_process(delta):
	if !character.is_on_floor():
		next_state = inair_state
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump(event)
		
func jump(event):
	character.velocity.y = -character.jump_velocity
	next_state = inair_state
	playback.travel(jump_animation)

func on_exit():
	pass
