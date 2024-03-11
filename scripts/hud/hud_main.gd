extends Control


func _ready():
	$MarginContainer/VBoxContainer/NewGame.grab_focus()

func _on_new_game_pressed():
	GameManager.load_game_scene()

func _on_options_pressed():
	GameManager.load_hud_main_settings_scene()

func _on_exit_pressed():
	GameManager.quit_game()
