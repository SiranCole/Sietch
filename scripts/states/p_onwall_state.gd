extends State
class_name OnWallState

@export var idle_state : State
@export var inair_state : State
@export var jump_animation : String = "Jump"
@export var move_animation : String = "Move"
@export var friction_accel : float
var wall_direction : int


func _ready():
	add_to_group("player_states")
	
func on_enter():
	update_wall_contact()

func state_process(delta):
	if character.is_on_floor():
		next_state = idle_state
		playback.travel(move_animation)
	elif not character.is_on_wall() or (!Input.is_action_pressed("left") and wall_direction==-1) or (!Input.is_action_pressed("right") and wall_direction==1):
		next_state = inair_state
		playback.travel(jump_animation)
		return
	else:
		update_wall_contact()
	
		
	#character.velocity.y = move_toward(character.velocity.y, 0, character.friction_accel * delta)

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump(event)
	
func on_exit():
	inair_state.time_off_wall = character.time_off_wall
	character.friction_accel = 0

func jump(event):
	var wall_jump_angle_in_rads = deg_to_rad(character.wall_jump_angle)
	character.velocity.y -=  sin(wall_jump_angle_in_rads) * character.jump_velocity
	character.velocity.x += cos(wall_jump_angle_in_rads) * character.jump_velocity * -wall_direction
	next_state = inair_state
	playback.travel(jump_animation)

func update_wall_contact():
	var normal_x = character.collision.get_normal().x
	if normal_x > 0:
		wall_direction = -1
	elif normal_x < 0:
		wall_direction = 1
	else:
		wall_direction = 0
		
	character.friction_accel = friction_accel
