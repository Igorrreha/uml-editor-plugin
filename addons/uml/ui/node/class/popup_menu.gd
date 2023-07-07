extends PopupMenu


signal remove_node_item_pressed
signal add_signal_pressed
signal add_variable_pressed
signal add_method_pressed


func open(popup_position: Vector2) -> void:
	popup(Rect2(popup_position, size))


func _on_id_pressed(id: int) -> void:
	match id:
		0:
			add_variable_pressed.emit()
		1:
			add_method_pressed.emit()
		2:
			add_signal_pressed.emit()
		4:
			remove_node_item_pressed.emit()
