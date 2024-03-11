extends Control


func _ready():
	$MarginContainer/Back.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	GameManager.load_hud_main_scene()
