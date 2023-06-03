class_name UmlClassNodeDescription
extends Resource


@export var node_class_name: String
@export var node_script: Script

@export var parent_class_name: String

@export_group("Graph node")
@export var position_offset: Vector2

@export_group("Class members")


func _init(class_node: UmlClassNode) -> void:
	position_offset = class_node.position_offset
	node_class_name = class_node.get_node_class_name()
	parent_class_name = class_node.get_parent_class_name()
