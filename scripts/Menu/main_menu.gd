extends Control

@export var main_scene: MainScene

func _on_play_pressed() -> void:
	main_scene.start_game()
