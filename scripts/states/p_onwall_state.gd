extends State
class_name OnWallState

@export var idleState : State
@export var inAirState : State
@export var jumpAnimation : String = "Jump"
@export var moveAnimation : String = "Move"
@export var frictionAccel : float
var wallDirection : int


func _ready():
	add_to_group("PLAYER_STATES")
	
func on_enter():
	update_wall_contact()

func state_process(delta):
	if character.is_on_floor():
		nextState = idleState
		playback.travel(moveAnimation)
	elif not character.is_on_wall() or (!Input.is_action_pressed("left") and wallDirection==-1) or (!Input.is_action_pressed("right") and wallDirection==1):
		nextState = inAirState
		playback.travel(jumpAnimation)
		return
	else:
		update_wall_contact()
	
		
	#character.velocity.y = move_toward(character.velocity.y, 0, character.friction_accel * delta)

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump(event)
	
func on_exit():
	inAirState.timeOffWall = character.timeOffWall
	character.frictionAccel = 0

func jump(event):
	var wallJumpAngleInRads = deg_to_rad(character.wallJumpAngle)
	character.velocity.y =  -sin(wallJumpAngleInRads) * character.jumpVelocity
	character.velocity.x = cos(wallJumpAngleInRads) * character.jumpVelocity * -wallDirection
	nextState = inAirState
	playback.travel(jumpAnimation)

func update_wall_contact():
	var normalX = character.collision.get_normal().x
	if normalX > 0:
		wallDirection = -1
	elif normalX < 0:
		wallDirection = 1
	else:
		wallDirection = 0
		
	character.frictionAccel = frictionAccel
