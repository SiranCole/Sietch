extends CharacterBody2D
class_name Player

@export var inertia : float = 1.0
@export var maxSpeed : float = 300.0
@export var jump_velocity : float = 500.0
@export var wall_jump_angle : float = 90
@export var flight_offset : int
@export var time_off_wall : float = 0.1

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : PlayerStateMachine = $PlayerStateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var collision = null
var friction_accel : float = 0

func _ready():
	animation_tree.active = true
func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		if friction_accel:
			velocity.y = move_toward(velocity.y, 0, friction_accel * delta)
	
	direction = Input.get_vector("left", "right","up","down")
	if direction.x != 0 && state_machine.check_if_can_move():
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
	animation_tree.set("parameters/Move/blend_position", direction.x)
	animation_tree.set("parameters/Jump/blend_position", get_jump_phase())
	
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func get_jump_phase():
	if velocity.y < -flight_offset:
		return -1
	elif velocity.y > flight_offset:
		return 1
	else:
		return 0
		
		

