class_name UmlClassNodeVariable
extends UmlClassNodeMember


@export var _access_modifier_field: OptionButton
@export var _name_field: LineEdit
@export var _type_field: LineEdit


func setup(state: UmlClassVariableState) -> void:
	super.setup(state)
	state.setup_bindings(self, "state", [
		ReactiveResource.Binding
			.new("access_modifier", _on_state_access_modifier_updated, set_access_modifier),
		ReactiveResource.Binding
			.new("name", _on_state_name_updated, set_variable_name),
		ReactiveResource.Binding
			.new("type", _on_state_type_updated, set_variable_type),
	])


func _on_state_access_modifier_updated() -> void:
	_access_modifier_field.select((state as UmlClassVariableState).access_modifier)


func _on_state_name_updated() -> void:
	_name_field.text = (state as UmlClassVariableState).name


func _on_state_type_updated() -> void:
	_type_field.text = (state as UmlClassVariableState).type


func set_access_modifier(modifier: Uml.ClassMemberAccessModifier) -> void:
	state.set_value("access_modifier", modifier, set_access_modifier)


func set_variable_name(new_text: String) -> void:
	state.set_value("name", new_text, set_variable_name)


func set_variable_type(new_text: String) -> void:
	state.set_value("type", new_text, set_variable_type)


func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		var popup = $PopupMenu as PopupMenu
		popup.popup(Rect2(event.global_position, popup.size))
