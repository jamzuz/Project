@tool
extends EditorScript

func _run():
	if Engine.is_editor_hint():
		get_scene().process_image()
		return
