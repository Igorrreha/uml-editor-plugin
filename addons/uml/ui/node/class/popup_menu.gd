extends PopupMenu


@export var _class_node_members_container: UmlClassNodeMembersContainer


func _on_id_pressed(id: int) -> void:
	match id:
		0:
			_class_node_members_container.add_variable()
#		1:
#			_class_node_members_container.add_method()
#		2:
#			_class_node_members_container.add_signal()


func _on_class_node_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		open()


func open():
	popup(Rect2(get_mouse_position(), size))
