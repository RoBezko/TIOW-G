extends Area3D

var entered: bool = false

func on_body_entered(body: Node3D) -> void:
	if body is PlayerController and not entered:
		var music = Global.main_scene.plr.sfx.music
		var sfx = Global.main_scene.plr.sfx
		sfx.play_sfx(music, preload("uid://dlklbx3l4hgti"))
		entered = true
