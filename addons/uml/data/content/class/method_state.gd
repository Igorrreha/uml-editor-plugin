class_name UmlClassMethodState
extends ReactiveResource


@export var access_modifier: Uml.ClassMemberAccessModifier
@export var name: String
@export var arguments: Array[UmlClassArgumentState]
@export var return_type: String


func _init(access_modifier: Uml.ClassMemberAccessModifier, name: String,
		return_type: String, arguments: Array[UmlClassArgumentState]) -> void:
	self.access_modifier = access_modifier
	self.name = name
	self.return_type = return_type
	self.arguments = arguments
