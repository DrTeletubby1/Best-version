# Extends Label class to display and update the score
extends Label

# Variable to track the score
var score = 0

# Cache reference to the player node, assumed to be in a group named "player"
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
# Variable to track if the player is dead
var dead = false

# Function to handle the player's death
func kill():
	# Set the dead state to true
	dead = true
	# Increment the score by 1
	score += 1
	# Update the label text to display the new score
	text = "Score: %s" % score
