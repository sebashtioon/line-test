extends Control


func _on_playbtn_pressed() -> void:
	$bg.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://src/main/main.tscn")
