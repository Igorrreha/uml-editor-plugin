class_name UmlClassNodeVariable
extends HBoxContainer


signal removing_requested


@export var _access_modifier_node: OptionButton
@export var _name_node: LineEdit
@export var _type_node: LineEdit


var state: UmlClassVariableState


func setup(state: UmlClassVariableState) -> void:
	state.setup_bindings(self, "state", [
		ReactiveResource.Binding
			.new("access_modifier", _on_state_access_modifier_updated, set_access_modifier),
		ReactiveResource.Binding
			.new("name", _on_state_name_updated, set_variable_name),
		ReactiveResource.Binding
			.new("type", _on_state_type_updated, set_variable_type),
	])


func set_access_modifier(modifier: Uml.ClassMemberAccessModifier) -> void:
	state.set_value("access_modifier", modifier, set_access_modifier)


func set_variable_name(new_text: String) -> void:
	state.set_value("name", new_text, set_variable_name)


func set_variable_type(new_text: String) -> void:
	state.set_value("type", new_text, set_variable_type)


func request_removing() -> void:
	removing_requested.emit()


func _exit_tree() -> void:
	state.remove_callback("access_modifier", _on_state_access_modifier_updated)
	state.remove_callback("name", _on_state_name_updated)
	state.remove_callback("type", _on_state_type_updated)


func _on_state_access_modifier_updated() -> void:
	_access_modifier_node.select((state as UmlClassVariableState).access_modifier)


func _on_state_name_updated() -> void:
	_name_node.text = (state as UmlClassVariableState).name


func _on_state_type_updated() -> void:
	_type_node.text = (state as UmlClassVariableState).type


func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		var popup = $PopupMenu as PopupMenu
		popup.popup(Rect2(event.global_position, popup.size))
