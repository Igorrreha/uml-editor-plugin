class_name UmlClassNode
extends UmlNode


var _default_name: String = "Class"
var _default_parent_name: String = "Object"

var _state: UmlClassState


func setup(node_state: UmlNodeState) -> void:
	super.setup(node_state)
	
	node_state.setup_bindings(self, "_state", [
		ReactiveResource.Binding
			.new("self_class_name", _on_state_self_class_name_changed),
		ReactiveResource.Binding
			.new("parent_class_name", _on_state_parent_class_name_changed),
		ReactiveResource.Binding
			.new("signals", _on_state_signals_changed, _update_signals),
		ReactiveResource.Binding
			.new("variables", _on_state_variables_changed, _update_variables),
		ReactiveResource.Binding
			.new("methods", _on_state_methods_changed, _update_methods),
	])


func add_signal(description: UmlSignalDescription) -> void:
	_state.signals.append(description)
	_update_signals()


func remove_signal(description: UmlSignalDescription) -> void:
	_state.signals.remove_at(_state.signals.find(description))
	_update_signals()


func add_variable(description: UmlVariableDescription) -> void:
	_state.variables.append(description)
	_update_variables()


func remove_variable(description: UmlVariableDescription) -> void:
	_state.variables.remove_at(_state.variables.find(description))
	_update_variables()


func add_method(description: UmlMethodDescription) -> void:
	_state.methods.append(description)
	_update_methods()


func remove_method(description: UmlMethodDescription) -> void:
	_state.methods.remove_at(_state.methods.find(description))
	_update_methods()


func _on_state_self_class_name_changed() -> void:
	pass


func _on_state_parent_class_name_changed() -> void:
	pass


func _on_state_signals_changed() -> void:
	pass


func _on_state_variables_changed() -> void:
	pass


func _on_state_methods_changed() -> void:
	pass


func _update_signals() -> void:
	_state.set_value("signals", _state.signals, _update_signals)


func _update_variables() -> void:
	_state.set_value("variables", _state.variables, _update_variables)


func _update_methods() -> void:
	_state.set_value("methods", _state.methods, _update_methods)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		get_viewport().set_input_as_handled()
