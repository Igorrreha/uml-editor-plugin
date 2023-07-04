class_name UmlClassVariableState
extends ReactiveResource


@export var access_modifier: Uml.ClassMemberAccessModifier
@export var name: String
@export var type: String


func _init(access_modifier: Uml.ClassMemberAccessModifier = Uml.ClassMemberAccessModifier.PRIVATE,
		name: String = "variable_name", type: String = "Type") -> void:
	self.access_modifier = access_modifier
	self.name = name
	self.type = type
