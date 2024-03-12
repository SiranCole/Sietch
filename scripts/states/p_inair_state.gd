extends State

class_name InAirState

@export var idle_state : State
@export var onwall_state : State
@export var wall_slide_animation : String = "Wall Slide"
@export var move_animation : String = "Move"
var time_off_wall : float

func _ready():
	add_to_group("player_states")

func on_enter():
	pass

func state_process(delta):
	if character.is_on_floor():
		next_state = idle_state
		playback.travel(move_animation)
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and character.is_on_wall():
		next_state = onwall_state
		playback.travel(wall_slide_animation)
	if time_off_wall > 0:
		time_off_wall -= delta
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		if time_off_wall > 0:
			jump(event)
		
func on_exit():
	pass
	
func jump(event):
	character.velocity.y -= character.jump_velocity
