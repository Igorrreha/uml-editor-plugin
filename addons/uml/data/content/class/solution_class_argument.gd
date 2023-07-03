class_name UmlSolutionClassArgument
extends ReactiveResource


@export var name: String
@export var type: String


func _init(name: String, type: String) -> void:
	self.name = name
	self.type = type
