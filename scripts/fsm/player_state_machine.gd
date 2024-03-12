extends Node

class_name PlayerStateMachine

@export var character : CharacterBody2D
@export var animationTree : AnimationTree
@export var currentState : State

var states : Array[State]

func _ready():
	for child in get_tree().get_nodes_in_group("PLAYER_STATES"):
		if (child is State):
			states.append(child)
			
			# Set the states up with what they need to function
			child.character = character
			child.playback = animationTree["parameters/playback"]
		else:
			push_warning("Child " + child.name + " is not a State for PlayerStateMachine")

func _physics_process(delta):
	if(currentState.nextState != null):
		switch_states(currentState.nextState)
		
	currentState.state_process(delta)

func check_if_can_move():
	return currentState.canMove
	
func switch_states(newState : State):
	if currentState != null:
		currentState.on_exit()
		currentState.nextState = null
	currentState = newState
	
	currentState.on_enter()
	
func _input(event : InputEvent):
	currentState.state_input(event)
