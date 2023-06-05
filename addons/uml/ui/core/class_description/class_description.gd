class_name UmlClassDescription
extends Resource


@export var _class_name: String
@export var _parent_class_name: String

@export var _signals: Array[UmlSignalDescription]
@export var _variables: Array[UmlVariableDescription]
@export var _methods: Array[UmlMethodDescription]


func get_class_name() -> String:
	return _class_name

func get_parent_class_name() -> String:
	return _parent_class_name

func get_signals() -> Array[UmlSignalDescription]:
	return _signals

func get_variables() -> Array[UmlVariableDescription]:
	return _variables

func get_methods() -> Array[UmlMethodDescription]:
	return _methods


func _init(name: String, parent_name: String, signals: Array[UmlSignalDescription],
		variables: Array[UmlVariableDescription],
		methods: Array[UmlMethodDescription]) -> void:
	_class_name = name
	_parent_class_name = parent_name
	
	_signals = signals
	_variables = variables
	_methods = methods
