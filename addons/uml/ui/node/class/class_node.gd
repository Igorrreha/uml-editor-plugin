class_name ClassNode
extends UmlNode


enum AccessModifier {
	PUBLIC,
	PRIVATE,
}


var _node_class_name: String = "Class"

var _signals: Array[SignalDescription]
var _variables: Array[VariableDescription]
var _methods: Array[MethodDescription]


class VariableDescription:
	var access_modifier: AccessModifier
	var name: String
	var type: String


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
