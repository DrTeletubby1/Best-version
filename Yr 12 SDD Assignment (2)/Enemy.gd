# Extends CharacterBody3D class for a 3D character controller
extends CharacterBody3D

# Cache reference to the 3D animated sprite node
@onready var animated_sprite_3d = $AnimatedSprite3D

# Exported variables to adjust movement speed and attack range
@export var move_speed = 2.0
@export var attack_range = 2.0

# Cache reference to the player node, assumed to be in a group named "player"
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
# Variable to track if the character is dead
var dead = false

# Handle physics-related updates
func _physics_process(_delta):
	# Ignore further processing if the character is dead
	if dead:
		return
	# Return if player reference is not found
	if player == null:
		return
	
	# Calculate direction to the player, ignoring vertical difference
	var dir = player.global_position - global_position 
	dir.y = 0.0
	dir = dir.normalized()

	# Apply movement speed to the character's velocity and move
	velocity = dir * move_speed
	move_and_slide()
	# Attempt to kill the player if within range
	attempt_to_kill_player()

# Attempt to kill the player if within attack range
func attempt_to_kill_player():
	# Calculate distance to the player
	var dist_to_player = global_position.distance_to(player.global_position)
	# Return if player is out of attack range
	if dist_to_player > attack_range:
		return
	
	# Define a ray from the character's eye line to the player's eye line
	var eye_line = Vector3.UP * 1.5
	var query = PhysicsRayQueryParameters3D.create(global_position + eye_line, player.global_position + eye_line, 1)
	# Perform raycast to check if there is a clear line of sight to the player
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	# If there is no obstacle between character and player, call the player's kill method
	if result.is_empty():
		player.kill()

# Handle the character's death
func kill():
	# Set the dead state to true and play the death sound and animation
	dead = true
	$DeathSound.play()
	animated_sprite_3d.play("death")
	# Disable the collision shape to prevent further interactions
	$CollisionShape3D.disabled = true
