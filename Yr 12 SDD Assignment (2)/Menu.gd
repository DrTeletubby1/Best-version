# Extends Control class for UI handling
extends Control

# Function to handle the play button press event
func _on_play_pressed():
	# Change the current scene to the game world scene
	get_tree().change_scene_to_file("res://world.tscn")

# Function to handle the options button press event
func _on_options_pressed():
	# Change the current scene to the options menu scene
	get_tree().change_scene_to_file("res://Options_menu.tscn")

# Function to handle the quit button press event
func _on_quit_pressed():
	# Quit the game application
	get_tree().quit()
