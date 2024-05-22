# Extends Control class for UI handling
extends Control

# Variable to track the score
var Score = 0

# Reference to the UI element displaying the score
@onready var score = $Score

# Called when the node is added to the scene
func _ready():
	pass

# Process function called every frame
func _process(delta):
	# Increment the score by 1 each frame
	Score += 1
