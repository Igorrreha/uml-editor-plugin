class_name UmlClassNode
extends UmlNode


enum AccessModifier {
	PUBLIC,
	PRIVATE,
}


var _node_class_name: String = "Class"

var _signals: Array[SignalDescription]
var _variables: Array[VariableDescription]
var _methods: Array[MethodDescription]


func add_signal(description: SignalDescription) -> void:
	_signals.append(description)


func add_variable(description: VariableDescription) -> void:
	_variables.append(description)


func add_method(description: MethodDescription) -> void:
	_methods.append(description)


func remove_signal(description: SignalDescription) -> void:
	_signals.remove_at(_signals.find(description))


func remove_variable(description: VariableDescription) -> void:
	_variables.remove_at(_variables.find(description))


func remove_method(description: MethodDescription) -> void:
	_methods.remove_at(_methods.find(description))


class VariableDescription:
	var access_modifier: AccessModifier
	var name: String
	var type: String
	
	func _init(access_modifier: AccessModifier, name: String, type: String) -> void:
		self.access_modifier = access_modifier
		self.name = name
		self.type = type


class MethodArgumentDescription:
	var name: String
	var type: String


class MethodDescription:
	var access_modifier: AccessModifier
	var name: String
	var arguments: Array[MethodArgumentDescription]
	var return_type: String


class SignalDescription:
	var name: String
	var arguments: Array[MethodArgumentDescription]
