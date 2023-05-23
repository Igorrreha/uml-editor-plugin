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


func remove_signal(description: SignalDescription) -> void:
	_signals.remove_at(_signals.find(description))


func add_variable(description: VariableDescription) -> void:
	_variables.append(description)


func remove_variable(description: VariableDescription) -> void:
	_variables.remove_at(_variables.find(description))


func add_method(description: MethodDescription) -> void:
	_methods.append(description)


func remove_method(description: MethodDescription) -> void:
	_methods.remove_at(_methods.find(description))


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		get_viewport().set_input_as_handled()


class VariableDescription:
	var access_modifier: AccessModifier
	var name: String
	var type: String
	
	func _init(access_modifier: AccessModifier, name: String, type: String) -> void:
		self.access_modifier = access_modifier
		self.name = name
		self.type = type


class ArgumentDescription:
	var name: String
	var type: String
	
	func _init(name: String, type: String) -> void:
		self.name = name
		self.type = type


class MethodDescription:
	var access_modifier: AccessModifier
	var name: String
	var arguments: Array[ArgumentDescription]
	var return_type: String
	
	func _init(access_modifier: AccessModifier, name: String, 
			arguments: Array[ArgumentDescription]) -> void:
		self.access_modifier = access_modifier
		self.name = name
		self.arguments = arguments


class SignalDescription:
	var name: String
	var arguments: Array[ArgumentDescription]
	
	func _init(name: String, arguments: Array[ArgumentDescription]) -> void:
		self.name = name
		self.arguments = arguments
