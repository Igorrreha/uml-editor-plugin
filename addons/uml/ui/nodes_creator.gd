extends Node


@export var _tscn_class_node: PackedScene
@export var _graph: UmlGraph


func create_class_node(position: Vector2) -> void:
	var new_node = _tscn_class_node.instantiate() as GraphNode
	new_node.position_offset = ((position + _graph.scroll_offset) / _graph.zoom
		- _graph.global_position)
	_graph.add_child(new_node)
