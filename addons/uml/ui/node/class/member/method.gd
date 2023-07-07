class_name UmlClassNodeMethod
extends HBoxContainer


signal removing_requested


@export var _access_modifier_node: OptionButton
@export var _name_node: LineEdit
@export var _type_node: LineEdit
@export var _arguments_container: UmlClassNodeArgumentsContainer


var state: UmlClassMethodState


func setup(state: UmlClassMethodState) -> void:
	state.setup_bindings(self, "state", [
		ReactiveResource.Binding
			.new("access_modifier", _on_state_access_modifier_updated, set_method_access_modifier),
		ReactiveResource.Binding
			.new("name", _on_state_name_updated, set_method_name),
		ReactiveResource.Binding
			.new("return_type", _on_state_return_type_updated, set_method_return_type),
	])
	
	_arguments_container.setup(state.get_handler("arguments"))


func request_removing() -> void:
	removing_requested.emit()


func set_method_access_modifier(new_value: Uml.ClassMemberAccessModifier) -> void:
	state.set_value("access_modifier", new_value, set_method_access_modifier)


func set_method_name(new_value: String) -> void:
	state.set_value("name", new_value, set_method_name)


func set_method_return_type(new_value: String) -> void:
	state.set_value("return_type", new_value, set_method_return_type)


func _exit_tree() -> void:
	state.remove_callback("access_modifier", _on_state_access_modifier_updated)
	state.remove_callback("name", _on_state_name_updated)
	state.remove_callback("return_type", _on_state_return_type_updated)


func _on_state_access_modifier_updated() -> void:
	_access_modifier_node.select(state.access_modifier)


func _on_state_name_updated() -> void:
	_name_node.text = state.name


func _on_state_return_type_updated() -> void:
	_type_node.text = state.return_type


func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		var popup = $PopupMenu as PopupMenu
		popup.popup(Rect2(event.global_position, popup.size))
