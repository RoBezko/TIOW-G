extends Control


func _on_check_button_pressed() -> void:
	$sig.play()
	$CheckButton.disabled = true
	$Panel.visible = true
	await $sig.finished
	$AnimationPlayer.play("PanelShow")
	await $AnimationPlayer.animation_finished

	Global.startAnimFinished = true
	Global.main_scene.plr_camera.get_parent().set_process_input(true)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Document.visible = false
	$CheckButton.visible = false

	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("PanelHide")
