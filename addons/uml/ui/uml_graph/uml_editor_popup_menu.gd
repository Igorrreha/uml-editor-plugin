extends PopupMenu


signal class_node_creation_requested(position: Vector2)
signal selected_class_nodes_removing_requested
signal selected_nodes_saving_requested


@export var _selected_nodes_provider: UmlSelectedNodesProvider


func _on_id_pressed(id):
	match id:
		0:
			class_node_creation_requested.emit(position)
		2:
			selected_class_nodes_removing_requested.emit()
		3:
			selected_nodes_saving_requested.emit()


func _on_about_to_popup() -> void:
	_update_popup_items()


func _update_popup_items() -> void:
	var nodes_not_selected: bool = _selected_nodes_provider.provide().is_empty()
	set_item_disabled(2, nodes_not_selected)
	set_item_disabled(3, nodes_not_selected)
