extends Node
class_name MainScene

@onready var main_menu: Control = $UI/MainMenu
@onready var level_holder: Node3D = $LevelHolder
@onready var plr: PlayerController = $PLR
@onready var plr_camera := $PLR/CameraController/Camera3D

@onready var start_visual: Control = $UI/StartVisual
@onready var start_visual_anim: AnimationPlayer = $UI/StartVisual/AnimationPlayer
@onready var folder_appear: Control = $UI/FolderAppear
@onready var folder_appear_anim: AnimationPlayer = $UI/FolderAppear/AnimationPlayer
@onready var show_interact: Control = $UI/ShowInteract
@onready var show_interact_anim: AnimationPlayer = $UI/ShowInteract/Anim

@onready var ending: Control = $UI/Ending
@onready var credits: Control = $UI/Credits
@onready var credits_anim: AnimationPlayer = $UI/Credits/AnimationPlayer

@onready var hud: HUD = $UI/HUD
@onready var rain: GPUParticles3D = $PLR/Rain

var current_level: Node = null
var is_changing_level: bool = false

func _ready() -> void:
	Global.main_scene = self
	current_level = level_holder.get_child(0)
	_start_menu_setup()

func _start_menu_setup() -> void:
	main_menu.visible = true
	Global.is_in_menu = true
	
	hud.visible = false
	
	plr.visible = false
	plr.set_physics_process(false)
	plr.set_process(false)
	plr.set_process_input(false)
	plr_camera.get_parent().set_process_input(false)
	
	current_level.visible = false
	
	plr.sfx.stop_all()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc") and not Global.is_in_menu:
		get_tree().quit()

func start_intro():
	main_menu.visible = false
	
	
	if Global.startAnimFinished:
		hud.visible = true
	
	current_level.visible = true
	plr.visible = true
	plr.set_physics_process(true)
	plr.set_process(true)
	plr.set_process_input(true)
	plr_camera.get_parent().set_process_input(true)
	
	plr_camera.make_current()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.is_in_menu = false
	start_visual.visible = true
	await get_tree().create_timer(2).timeout
	start_visual_anim.play("Fade out")
	await start_visual_anim.animation_finished
	start_visual.visible = false
	
	var music = Global.main_scene.plr.sfx.music
	var sfx = Global.main_scene.plr.sfx
	sfx.play_sfx(music, preload("uid://co2fi8mkwdm81"))
	
	if current_level.name == "StartScene":
		current_level.talking.play()
		await current_level.talking.finished
		current_level.stopped_talking = true

func start_game():
	main_menu.visible = false
	
	
	if Global.startAnimFinished:
		hud.visible = true
	
	current_level.visible = true
	plr.visible = true
	plr.set_physics_process(true)
	plr.set_process(true)
	plr.set_process_input(true)
	plr_camera.get_parent().set_process_input(true)
	
	plr_camera.make_current()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.is_in_menu = false

func _return_to_menu():
	_start_menu_setup()

func change_level(new_level_path: String, landmark_name: String = "Landmark"):
	if is_changing_level:
		return
	if new_level_path == "":
		push_error("change_level called with empty path")
		return
	is_changing_level = true

	var new_level_scene: PackedScene = load(new_level_path)
	if new_level_scene == null:
		push_error("Failed to load level at path: " + new_level_path)
		is_changing_level = false
		return

	var old_landmark = current_level.get_node_or_null(landmark_name)
	var player_offset = Vector3.ZERO
	if old_landmark:
		player_offset = plr.global_transform.origin - old_landmark.global_transform.origin

	var new_level = new_level_scene.instantiate()
	level_holder.add_child(new_level)

	var new_landmark = new_level.get_node_or_null(landmark_name)
	if new_landmark:
		plr.global_transform.origin = new_landmark.global_transform.origin + player_offset

	current_level.queue_free()
	current_level = new_level
	is_changing_level = false
