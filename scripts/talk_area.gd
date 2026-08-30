extends Area3D

@export var Voice_Line: AudioStreamMP3

var played_voiceline: bool = false

func on_body_entered(body: Node3D) -> void:
	if body is PlayerController and not played_voiceline:
		body.sfx.play_sfx(body.sfx.va, Voice_Line)
		played_voiceline = true

func on_body_exited(body: Node3D) -> void:
	if body is PlayerController:
		played_voiceline = false
