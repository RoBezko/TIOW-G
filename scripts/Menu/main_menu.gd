extends Control

@export var main_scene: MainScene

@onready var back: Sprite2D = $Back

func _on_play_pressed() -> void:
	if not Global.startAnimFinished:
		main_scene.start_intro()
	else:
		main_scene.start_game()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pass
