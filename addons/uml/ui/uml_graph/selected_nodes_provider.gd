class_name UmlSelectedNodesProvider
extends Node


@export var _graph: UmlGraph
var _selected_nodes: Array[UmlNode]


func provide() -> Array[UmlNode]:
	var duplicate = _selected_nodes.duplicate()
	duplicate.make_read_only()
	return duplicate


func on_graph_edit_node_selected(node: UmlNode) -> void:
	_selected_nodes.append(node)


func on_graph_edit_node_deselected(node: UmlNode) -> void:
	_selected_nodes.erase(node)
