extends Node3D

@export var exit: Area3D
@onready var talking: AudioStreamPlayer3D = $Talking
var stopped_talking: bool = false

func _process(delta: float) -> void:
	if talking.finished and stopped_talking:
		Global.main_scene.show_interact.visible = true
		Global.main_scene.show_interact_anim.play("AnimStart")
		stopped_talking = false
	
	if Input.is_action_just_pressed("Interact"):
		Global.main_scene.plr.sfx.play_sfx(Global.main_scene.plr.sfx.misc, preload("uid://do8l1brcbskej"))
		Global.main_scene.folder_appear.visible = true
		Global.main_scene.show_interact.visible = false
		Global.main_scene.folder_appear_anim.play("FolderCameIn")
		Global.main_scene.plr_camera.get_parent().set_process_input(false)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Global.startAnimFinished:
		Global.input_activated = true
		Global.main_scene.hud.visible = true
		Global.main_scene.rain.emitting = true
		Global.main_scene.plr.flash_hold.visible = true
		Global.main_scene.plr.ambiant_light.visible = true
		exit.monitoring = true
