extends Node


@export var _tscn_class_node: PackedScene
@export var _container: Node


func create_class_node(position: Vector2) -> void:
	var new_node = _tscn_class_node.instantiate() as GraphNode
	new_node.position_offset = position
	_container.add_child(new_node)
