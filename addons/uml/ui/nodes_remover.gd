extends Node


@export var _selected_nodes_provider: UmlSelectedNodesProvider


func remove_selected_nodes() -> void:
	for node in _selected_nodes_provider.provide():
		node.queue_free()
