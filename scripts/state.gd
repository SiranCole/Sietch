extends Node

class_name State

@export var canMove : bool = true

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var nextState : State

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass
	
func on_enter():
	pass

func on_exit():
	pass
