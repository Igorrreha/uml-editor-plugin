class_name UmlArgumentDescription
extends Resource


@export var _node_class_name: String
@export var _parent_class_name: String


func _init(name: String, type: String) -> void:
	self.name = name
	self.type = type
