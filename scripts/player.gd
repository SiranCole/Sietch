extends CharacterBody2D
class_name Player

@export var inertia : float = 1.0
@export var maxSpeed : float = 300.0
@export var jumpHeight : float = 100.0
@export var jumpTimeToPeak : float = 0.5
@export var jumpTimeToDescend : float = 0.4
@export var wallJumpAngle : float = 90
@export var flightTime : float = 0.42
@export var timeOffWall : float = 0.1

@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var animationTree : AnimationTree = $AnimationTree
@onready var stateMachine : PlayerStateMachine = $PlayerStateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var jumpVelocity : float = (2.0 * jumpHeight) / jumpTimeToPeak
@onready var jumpGravity : float = ((-2.0 * jumpHeight) / (jumpTimeToPeak * jumpTimeToPeak)) * -1.0
@onready var fallGravity : float = ((-2.0 * jumpHeight) / (jumpTimeToDescend * jumpTimeToDescend)) * -1.0
@onready var flightOffsetAscend : float = jumpGravity * (flightTime * fallGravity / (jumpGravity + fallGravity))
@onready var flightOffsetDescend : float = fallGravity * (flightTime * jumpGravity / (jumpGravity + fallGravity))
var animationLocked : bool = false
var direction : Vector2 = Vector2.ZERO
var collision = null
var frictionAccel : float = 0


func _ready():
	animationTree.active = true
func _physics_process(delta):
	_testing_update_jump_parameters()
	# Add the gravity
	if not is_on_floor():
		velocity.y += get_gravity() * delta
		if frictionAccel:
			velocity.y = move_toward(velocity.y, 0, frictionAccel * delta)
	
	direction = Input.get_vector("left", "right","up","down")
	if direction.x != 0 && stateMachine.check_if_can_move():
		velocity.x = move_toward(velocity.x, direction.x * maxSpeed, maxSpeed*(delta/(1.0000001-inertia)))
	else:
		velocity.x = move_toward(velocity.x, 0, maxSpeed*(delta/(1.0000001-inertia)))
		
		
	move_and_slide()
	for i in get_slide_collision_count():
		collision = get_slide_collision(i)
		#print(collision.get_collider().physics)
	update_animation()
	update_facing_direction()
	
func update_animation():
	animationTree.set("parameters/Move/blend_position", direction.x)
	animationTree.set("parameters/Jump/blend_position", get_jump_phase())
	
func update_facing_direction():
	if direction.x > 0:
		animatedSprite.flip_h = false
	elif direction.x < 0:
		animatedSprite.flip_h = true
		
func get_jump_phase():
	if velocity.y < -flightOffsetAscend:
		return -1
	elif velocity.y > flightOffsetDescend:
		return 1
	else:
		return 0
func get_gravity():
	return jumpGravity if velocity.y < 0.0 else fallGravity
func _testing_update_jump_parameters():
	jumpVelocity = (2.0 * jumpHeight) / jumpTimeToPeak
	jumpGravity = ((-2.0 * jumpHeight) / (jumpTimeToPeak * jumpTimeToPeak)) * -1.0
	fallGravity = ((-2.0 * jumpHeight) / (jumpTimeToDescend * jumpTimeToDescend)) * -1.0
	flightOffsetAscend = jumpGravity * (flightTime * fallGravity / (jumpGravity + fallGravity))
	flightOffsetDescend = fallGravity * (flightTime * jumpGravity / (jumpGravity + fallGravity))

