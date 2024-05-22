# Extends CharacterBody3D class for a 3D character controller
extends CharacterBody3D

# Cache references to the nodes in the scene tree when the node is ready
@onready var animated_sprite_2d = $CanvasLayer/GunBase/AnimatedSprite2D
@onready var ray_cast_3d = $RayCast3D
@onready var shoot_sound = $ShootSound

# Define constants for speed and mouse sensitivity
const SPEED = 5.0
const MOUSE_SENS = 0.5

# Initialize variables to track shooting capability and death state
var can_shoot = true
var dead = false

# Called when the node is added to the scene
func _ready():
	# Capture the mouse cursor
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# Connect the animation finished signal to the shoot_anim_done function
	animated_sprite_2d.animation_finished.connect(shoot_anim_done)
	# Connect the button press signal to the restart function
	$CanvasLayer/DeathScreen/Panel/Button.button_up.connect(restart)

# Handle input events
func _input(event):
	# Ignore input if the character is dead
	if dead:
		return
	# Handle mouse motion events to rotate the character
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENS

# Handle frame-based logic
func _process(_delta):
	# Quit the game if the exit action is pressed
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	# Restart the game if the restart action is pressed
	if Input.is_action_just_pressed("restart"):
		restart()

	# Ignore further input if the character is dead
	if dead:
		return
	# Call the shoot function if the shoot action is pressed
	if Input.is_action_just_pressed("shoot"):
		shoot()

# Handle physics-related updates
func _physics_process(_delta):
	# Ignore movement if the character is dead
	if dead:
		return
	# Get the input direction from movement actions
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	# Convert the input direction to world space and normalize it
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# Apply movement speed to the character's velocity
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		# Gradually reduce the velocity when there is no input
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Move the character and handle sliding
	move_and_slide()

# Restart the game by reloading the current scene
func restart():
	get_tree().reload_current_scene()

# Handle the shooting action
func shoot():
	# Prevent shooting if the character can't shoot
	if !can_shoot:
		return
	can_shoot = false
	# Play the shooting animation and sound
	animated_sprite_2d.play("Shoot")
	shoot_sound.play()
	# Check for collisions using the raycast and call the kill method on the collider if it has one
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill"):
		ray_cast_3d.get_collider().kill()

# Called when the shooting animation is finished
func shoot_anim_done():
	# Allow the character to shoot again
	can_shoot = true

# Handle the character's death
func kill():
	# Set the dead state to true and show the death screen
	dead = true
	$CanvasLayer/DeathScreen.show()
	# Make the mouse cursor visible again
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
