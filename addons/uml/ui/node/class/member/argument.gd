class_name UmlClassNodeArgument
extends HBoxContainer


signal removing_requested


@export var _name_node: LineEdit
@export var _type_node: LineEdit

var state: UmlClassArgumentState


func setup(state: UmlClassArgumentState) -> void:
	state.setup_bindings(self, "state", [
		ReactiveResource.Binding
			.new("name", _on_state_name_updated, set_argument_name),
		ReactiveResource.Binding
			.new("type", _on_state_type_updated, set_argument_type),
	])


func request_removing() -> void:
	removing_requested.emit()


func set_argument_name(new_text: String) -> void:
	state.set_value("name", new_text, set_argument_name)


func set_argument_type(new_text: String) -> void:
	state.set_value("type", new_text, set_argument_type)


func _exit_tree() -> void:
	state.remove_callback("name", _on_state_name_updated)
	state.remove_callback("type", _on_state_type_updated)


func _on_state_name_updated() -> void:
	_name_node.text = state.name


func _on_state_type_updated() -> void:
	_type_node.text = state.type


func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		var popup = $PopupMenu as PopupMenu
		popup.popup(Rect2(event.global_position, popup.size))
