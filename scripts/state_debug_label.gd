extends Label

@export var player : Player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "State: " + player.state_machine.current_state.name + "\nJump Blend: " + str(player.velocity.y)+ "\nSpeed: " + str(player.velocity.x)
