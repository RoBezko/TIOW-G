extends Node3D

@onready var gate_sfx: AudioStreamPlayer3D = $GateSFX

func _ready() -> void:
	if not Global.entered_city:
		gate_sfx.play()
		Global.entered_city = true
