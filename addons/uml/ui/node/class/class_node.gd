class_name UmlClassNode
extends UmlNode


var _default_name: String = "Class"
var _default_parent_name: String = "Object"

var _signals: Array[UmlSignalDescription]
var _variables: Array[UmlVariableDescription]
var _methods: Array[UmlMethodDescription]

@onready var description: = UmlClassDescription.new(_default_name, _default_parent_name,
	_signals, _variables, _methods)


var _state: UmlClassState


func setup(node_state: UmlNodeState) -> void:
	super.setup(node_state)
	
	if _state != null:
		_state.remove_callback("self_class_name", _on_state_self_class_name_changed)
		_state.remove_callback("parent_class_name", _on_state_parent_class_name_changed)
		_state.remove_callback("signals", _on_state_signals_changed)
		_state.remove_callback("variables", _on_state_variables_changed)
		_state.remove_callback("methods", _on_state_methods_changed)
	
	_state = node_state.content as UmlClassState
	_state.bind("self_class_name", _on_state_self_class_name_changed)
	_state.bind("parent_class_name", _on_state_parent_class_name_changed)
	_state.bind("signals", _on_state_signals_changed)
	_state.bind("variables", _on_state_variables_changed)
	_state.bind("methods", _on_state_methods_changed)
	
	_on_state_self_class_name_changed()
	_on_state_parent_class_name_changed()
	_on_state_signals_changed()
	_on_state_variables_changed()
	_on_state_methods_changed()


func add_signal(description: UmlSignalDescription) -> void:
	_signals.append(description)


func remove_signal(description: UmlSignalDescription) -> void:
	_signals.remove_at(_signals.find(description))


func add_variable(description: UmlVariableDescription) -> void:
	_variables.append(description)


func remove_variable(description: UmlVariableDescription) -> void:
	_variables.remove_at(_variables.find(description))


func add_method(description: UmlMethodDescription) -> void:
	_methods.append(description)


func remove_method(description: UmlMethodDescription) -> void:
	_methods.remove_at(_methods.find(description))


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


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		get_viewport().set_input_as_handled()
