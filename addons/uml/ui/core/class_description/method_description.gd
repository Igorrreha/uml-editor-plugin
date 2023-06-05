class_name UmlMethodDescription
extends Resource


@export var access_modifier: Uml.ClassMemberAccessModifier
@export var name: String
@export var arguments: Array[UmlArgumentDescription]
@export var return_type: String


func _init(access_modifier: Uml.ClassMemberAccessModifier, name: String,
		return_type: String, arguments: Array[UmlArgumentDescription]) -> void:
	self.access_modifier = access_modifier
	self.name = name
	self.return_type = return_type
	self.arguments = arguments
