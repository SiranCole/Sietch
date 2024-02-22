extends Node

#Global Scene Variables 
var hud_main_scene: PackedScene = preload("res://scenes/hud_main.tscn")
var game_scene: PackedScene = preload("res://scenes/game.tscn")
var hud_main_settings_scene: PackedScene = preload("res://scenes/hud_main_settings.tscn")

func load_hud_main_scene() -> void:
	get_tree().change_scene_to_packed(hud_main_scene)
	
func load_game_scene() -> void:
	get_tree().change_scene_to_packed(game_scene)
	
func load_hud_main_settings_scene() -> void:
	get_tree().change_scene_to_packed(hud_main_settings_scene)
	
func quit_game() -> void:
	get_tree().quit()
