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
	if not node.tree_exiting.is_connected(_on_node_exiting_tree):
		node.tree_exiting.connect(_on_node_exiting_tree.bind(node))


func on_graph_edit_node_deselected(node: UmlNode) -> void:
	_selected_nodes.erase(node)
	if node.tree_exiting.is_connected(_on_node_exiting_tree):
		node.tree_exiting.disconnect(_on_node_exiting_tree)


func _on_node_exiting_tree(node: UmlNode) -> void:
	_selected_nodes.erase(node)
