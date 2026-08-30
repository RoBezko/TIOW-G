extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body is PlayerController:
		Global.input_activated = false
		Global.main_scene.plr.set_physics_process(false)
		Global.main_scene.plr.set_process(false)
		Global.main_scene.plr.set_process_input(false)
		body.sfx.stop_all()
		body.sfx.play_sfx(body.sfx.va, preload("uid://dsm0nw2il5cmx"))
		await body.sfx.va.finished
		Global.main_scene.ending.visible = true
		body.sfx.play_sfx(body.sfx.va, preload("uid://dlvgc7obprjew"))
		await body.sfx.va.finished
		Global.main_scene.credits.visible = true
		Global.main_scene.credits_anim.play("Appear")
		body.sfx.play_sfx(body.sfx.music, preload("uid://djyyipntrhnuy"))
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
