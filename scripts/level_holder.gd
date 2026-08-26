extends Node3D

@export var PLR: PlayerController
var played_embiance: bool = false

func _process(delta: float) -> void:
	if not Global.is_in_menu and Global.startAnimFinished:
		if not played_embiance:
			PLR.sfx.play_sfx(PLR.sfx.ambiance, preload("uid://cl1i7e2e2lmcl"))
			played_embiance = true
	else:
		if played_embiance:
			PLR.sfx.ambiance.stop()
			played_embiance = false
	
