extends Node
class_name PLRsfxNode


@onready var flash_click: AudioStreamPlayer = $FlashClick
@onready var ambiance: AudioStreamPlayer = $Ambiance
@onready var rain_outdoors: AudioStreamPlayer = $RainOutdoors
@onready var misc: AudioStreamPlayer = $Misc

func play_sfx(player: AudioStreamPlayer, sfx: AudioStreamMP3):
	if not sfx == null:
		player.stream = sfx
	player.play()

func stop_all():
	flash_click.stop()
	ambiance.stop()
	rain_outdoors.stop()
