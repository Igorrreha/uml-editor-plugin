extends Node


@export var _tscn_class_node: PackedScene
@export var _graph: UmlGraph


func create_class_node(position: Vector2) -> void:
	var new_node = _tscn_class_node.instantiate() as UmlClassNode
	
	var node_position = ((position + _graph.scroll_offset) / _graph.zoom
		- _graph.global_position)
	
	var class_state = UmlClassState.new("Class", "Object", [], [], [])
	var node_state = UmlNodeState.new(node_position, class_state)
	new_node.setup(node_state)
	
	_graph.add_child(new_node)
