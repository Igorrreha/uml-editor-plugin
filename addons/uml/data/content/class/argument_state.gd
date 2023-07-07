class_name UmlClassArgumentState
extends ReactiveResource


@export var name: String
@export var type: String


func _init(name: String = "arg", type: String = "Variant") -> void:
	self.name = name
	self.type = type
