class_name UmlClassNodeSignal
extends HBoxContainer


signal removing_requested


@export var _name_node: LineEdit
@export var _arguments_container: UmlClassNodeArgumentsContainer


var state: UmlClassSignalState


func setup(state: UmlClassSignalState) -> void:
	state.setup_bindings(self, "state", [
		ReactiveResource.Binding
			.new("name", _on_state_name_updated, set_signal_name),
	])
	
	_arguments_container.setup(state.get_handler("arguments"))


func set_signal_name(new_text: String) -> void:
	state.set_value("name", new_text, set_signal_name)


func request_removing() -> void:
	removing_requested.emit()


func _exit_tree() -> void:
	state.remove_callback("name", _on_state_name_updated)


func _on_state_name_updated() -> void:
	_name_node.text = (state as UmlClassSignalState).name


func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		var popup = $PopupMenu as PopupMenu
		popup.popup(Rect2(event.global_position, popup.size))
