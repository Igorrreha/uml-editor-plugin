class_name UmlClassSignalState
extends ReactiveResource


@export var name: String
@export var arguments: Array[UmlClassArgumentState]


func _init(name: String, arguments: Array[UmlClassArgumentState]) -> void:
	self.name = name
	self.arguments = arguments