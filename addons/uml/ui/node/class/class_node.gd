class_name UmlClassNode
extends UmlNode


var _default_name: String = "Class"
var _default_parent_name: String = "Object"

var _signals: Array[UmlSignalDescription]
var _variables: Array[UmlVariableDescription]
var _methods: Array[UmlMethodDescription]

@onready var description: = UmlClassDescription.new(_default_name, _default_parent_name,
	_signals, _variables, _methods)


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


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		get_viewport().set_input_as_handled()
