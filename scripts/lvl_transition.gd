extends Area3D

@export var target_lvl: String = "res://Scenes/3DScenes/start_scene.tscn"
@export var target_landmark_name: String = "Landmark"

func on_body_entered(body):
	if body.is_in_group("PLR"):
		Global.main_scene.change_level(target_lvl, target_landmark_name)
