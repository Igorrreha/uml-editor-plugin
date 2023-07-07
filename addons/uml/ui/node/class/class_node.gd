class_name UmlClassNode
extends UmlNode


@export var _title_editor: UmlClassNodeTitleEditor

@export var _signals_container: UmlClassNodeSignalsContainer
@export var _variables_container: UmlClassNodeVariablesContainer
@export var _methods_container: UmlClassNodeMethodsContainer

var _state: UmlClassState


func setup(node_state: UmlNodeState) -> void:
	super.setup(node_state)
	_title_editor.setup(node_state.content.get_handler("self_class_name"),
		node_state.content.get_handler("parent_class_name"))
	_signals_container.setup(node_state.content.get_handler("signals"))
	_variables_container.setup(node_state.content.get_handler("variables"))
	_methods_container.setup(node_state.content.get_handler("methods"))


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		get_viewport().set_input_as_handled()
