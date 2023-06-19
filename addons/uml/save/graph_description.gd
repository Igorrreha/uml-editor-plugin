class_name UmlGraphDescription
extends Resource


@export var classes: Array[UmlClassDescription]
@export var connections: Array[UmlConnection]


func _init(classes: Array[UmlClassDescription], connections: Array[UmlConnection]) -> void:
	self.classes = classes
	self.connections = connections
