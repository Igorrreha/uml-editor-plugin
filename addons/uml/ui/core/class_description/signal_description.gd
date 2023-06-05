class_name UmlSignalDescription
extends Resource


@export var name: String
@export var arguments: Array[UmlArgumentDescription]


func _init(name: String, arguments: Array[UmlArgumentDescription]) -> void:
	self.name = name
	self.arguments = arguments
