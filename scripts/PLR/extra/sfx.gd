extends Node
class_name PLRsfxNode


@onready var flash_click: AudioStreamPlayer = $FlashClick
@onready var ambiance: AudioStreamPlayer = $Ambiance
@onready var rain_outdoors: AudioStreamPlayer = $RainOutdoors
@onready var misc: AudioStreamPlayer = $Misc
@onready var va: AudioStreamPlayer = $VA
@onready var music: AudioStreamPlayer = $Music

func play_sfx(player: AudioStreamPlayer, sfx: AudioStreamMP3):
	if sfx != null:
		player.stream = sfx
	await get_tree().process_frame
	player.play()

func stop_all():
	flash_click.stop()
	ambiance.stop()
	rain_outdoors.stop()
	misc.stop()
	va.stop()
	music.stop()
