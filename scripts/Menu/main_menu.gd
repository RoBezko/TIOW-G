extends Control

@export var main_scene: MainScene

func _on_play_pressed() -> void:
	if not Global.startAnimFinished:
		main_scene.start_intro()
	else:
		main_scene.start_game()
