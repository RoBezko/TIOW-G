extends Node3D

@export var PLR: PlayerController
@onready var camera: Camera3D = $Camera3D

const SENSITIVITY: float = 0.005

var Tbob = 0.0
var BOB_STP = 2.0
var BOB_AMP = 0.08

var BASE_FOV = 80.0
var FOV_DIF = 2.2

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	Tbob += delta * PLR.velocity.length() * float(PLR.is_on_floor())
	camera.transform.origin = _headbob(Tbob)
	
	var vel_clamped = clamp(PLR.velocity.length(), 0.5, PLR.SPEED * 2)
	var target_fov = BASE_FOV + FOV_DIF * vel_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_STP) * BOB_AMP
	pos.x = cos(time * BOB_STP / 2) * BOB_AMP
	return pos
	
