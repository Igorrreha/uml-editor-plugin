class_name UmlClassNode
extends UmlNode


@export var _signals_container: UmlClassNodeSignalsContainer
@export var _variables_container: UmlClassNodeVariablesContainer
@export var _methods_container: UmlClassNodeMethodsContainer

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
	])
	
	_signals_container.setup(node_state.content)
	_variables_container.setup(node_state.content)
	_methods_container.setup(node_state.content)


func _on_state_self_class_name_changed() -> void:
	pass


func _on_state_parent_class_name_changed() -> void:
	pass


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		get_viewport().set_input_as_handled()
