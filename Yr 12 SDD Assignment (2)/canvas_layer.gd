# Extends CanvasLayer class for UI handling
extends CanvasLayer

# Function to handle the back button press event
func _on_back_pressed():
	# Change the current scene to the menu scene
	get_tree().change_scene_to_file("res://menu.tscn")
