extends PopupMenu


signal class_node_creation_requested(Vector2)


func _on_id_pressed(id):
	match id:
		0:
			class_node_creation_requested.emit(position)
