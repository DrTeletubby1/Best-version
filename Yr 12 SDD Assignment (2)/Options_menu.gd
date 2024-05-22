# Extends Control class for UI handling
extends Control

# Function to handle the tutorial button press event
func _on_tutorial_pressed():
	# Change the current scene to the tutorial scene
	get_tree().change_scene_to_file("res://canvas_layer.tscn")

# Function to handle the back button press event
func _on_back_pressed():
	# Change the current scene to the menu scene
	get_tree().change_scene_to_file("res://menu.tscn")
