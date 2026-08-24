extends Node
class_name PLRsfxNode


@onready var flash_click: AudioStreamPlayer = $FlashClick


func play_sfx(player: AudioStreamPlayer, sfx: AudioStreamMP3):
	if not sfx == null:
		player.stream = sfx
	player.play()
