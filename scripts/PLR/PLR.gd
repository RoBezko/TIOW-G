extends CharacterBody3D
class_name PlayerController

const SPEED = 7.0
const JUMP_VELOCITY = 4.5

@export var sfx: PLRsfxNode

@onready var camera_controller: Node3D = $CameraController
@onready var flashlight_light: SpotLight3D = $CameraController/Camera3D/FlashlightLight

var flash_on: bool = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Flashlight"):
		flashlight_light.visible = !flash_on
		flash_on = !flash_on
		if flash_on:
			sfx.play_sfx(sfx.flash_click, preload("uid://b2a6n5h5qgbxm"))
		else:
			sfx.play_sfx(sfx.flash_click, preload("uid://bxnri416brew6"))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (camera_controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 7.5)
			velocity.z = lerp(velocity.z, direction.z * SPEED, delta * 7.5)
	else:
		velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 3.5)
		velocity.z = lerp(velocity.z, direction.z * SPEED, delta * 3.5)
	
	move_and_slide()
