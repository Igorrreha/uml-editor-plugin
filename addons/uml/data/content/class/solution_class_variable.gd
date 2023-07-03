class_name UmlSolutionClassVariable
extends ReactiveResource


@export var access_modifier: Uml.ClassMemberAccessModifier
@export var name: String
@export var type: String


func _init(access_modifier: Uml.ClassMemberAccessModifier, name: String, type: String) -> void:
	self.access_modifier = access_modifier
	self.name = name
	self.type = type
