extends Node
class_name MainScene

@onready var main_menu: Control = $UI/MainMenu
@onready var level_holder: Node3D = $LevelHolder
@onready var plr: PlayerController = $PLR
@onready var plr_camera := $PLR/CameraController/Camera3D

@export var other: Control
@onready var hud: Control = $UI/HUD

var current_level: Node = null

func _ready() -> void:
	current_level = level_holder.get_child(0)
	_start_menu_setup()

func _start_menu_setup() -> void:
	main_menu.visible = true
	Global.is_in_menu = true
	
	other.visible = false
	hud.visible = false
	
	plr.visible = false
	plr.set_physics_process(false)
	plr.set_process(false)
	plr.set_process_input(false)
	plr_camera.get_parent().set_process_input(false)
	
	current_level.visible = false
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc") and not Global.is_in_menu:
		_start_menu_setup()

func start_game():
	main_menu.visible = false
	Global.is_in_menu = false
	
	other.visible = true
	hud.visible = true
	
	current_level.visible = true
	plr.visible = true
	plr.set_physics_process(true)
	plr.set_process(true)
	plr.set_process_input(true)
	plr_camera.get_parent().set_process_input(true)
	
	plr_camera.make_current()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _return_to_menu():
	_start_menu_setup()
