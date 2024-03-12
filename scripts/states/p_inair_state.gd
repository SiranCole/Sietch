extends State

class_name InAirState

@export var idleState : State
@export var onWallState : State
@export var wallSlideAnimation : String = "Wall Slide"
@export var moveAnimation : String = "Move"
var timeOffWall : float

func _ready():
	add_to_group("PLAYER_STATES")

func on_enter():
	pass

func state_process(delta):
	if character.is_on_floor():
		nextState = idleState
		playback.travel(moveAnimation)
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and character.is_on_wall():
		nextState = onWallState
		playback.travel(wallSlideAnimation)
	if timeOffWall > 0:
		timeOffWall -= delta
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		if timeOffWall > 0:
			jump(event)
		
func on_exit():
	pass
	
func jump(event):
	character.velocity.y -= character.jumpVelocity
