class_name UmlClassNodeDescription
extends Resource


@export var node_script: Script

@export_group("Graph node")
@export var position_offset: Vector2

@export var class_description: UmlClassDescription


func _init(class_node: UmlClassNode) -> void:
	position_offset = class_node.position_offset
	class_description = class_node.description
	var a = class_node.description.get_class_name()
