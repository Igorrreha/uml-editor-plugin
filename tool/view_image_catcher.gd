@tool
extends EditorScript


func _run() -> void:
	var file_path = "res://screenshots/%s.png" % randi()
	get_scene().get_viewport().get_texture().get_image().save_png(file_path)
	print("Screenshot saved %s" % file_path)
