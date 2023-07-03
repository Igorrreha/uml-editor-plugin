class_name UmlSolutionClassSignal
extends ReactiveResource


@export var name: String
@export var arguments: Array[UmlSolutionClassArgument]


func _init(name: String, arguments: Array[UmlSolutionClassArgument]) -> void:
	self.name = name
	self.arguments = arguments
