extends Node


@export var _selected_nodes_provider: UmlSelectedNodesProvider
@export_dir var _save_directory: String

var _graph_name: String = "test"


func save() -> void:
	var graph_directory = _save_directory.path_join(_graph_name)
	if not DirAccess.dir_exists_absolute(graph_directory):
		DirAccess.make_dir_absolute(graph_directory)
	
	for node in _selected_nodes_provider.provide():
		if not node is UmlClassNode:
			continue
		
		var save_path = graph_directory.path_join(node.name) + ".tres"
		
		var error = ResourceSaver.save(node.state, save_path)
		if error:
			printerr("Node %s saving failed! Error code: %s" % [node, error])
		
		continue
