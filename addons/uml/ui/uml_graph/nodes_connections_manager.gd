class_name UmlNodesConnectionsManager
extends Node


signal connections_updated()

@export var _selected_nodes_provider: UmlSelectedNodesProvider

var _connections: Dictionary #[UmlNode, Dictionary[UmlNode, UmlConnection]]


func get_connections() -> Array[UmlConnection]:
	var connections: Array[UmlConnection]
	for group in _connections.values():
		connections.append_array(group.values())
	
	connections.make_read_only()
	return connections


func get_cross_connections() -> Array[UmlConnection]:
	var cross_connections: Array[UmlConnection]
	for node_from in _connections:
		for node_to in _connections[node_from]:
			if (_connections.has(node_to)
			and _connections[node_to].has(node_from)):
				cross_connections.append(_connections[node_from][node_to])
	
	cross_connections.make_read_only()
	return cross_connections


func connect_selected_nodes(connection_type: UmlConnection.Type) -> void:
	var selected_nodes = _selected_nodes_provider.provide()
	if selected_nodes.size() < 2:
		return
	
	_connect_chain(selected_nodes, connection_type)


func _connect(node_a: UmlNode, node_b: UmlNode, connection_type: UmlConnection.Type) -> void:
	if not _connections.has(node_a):
		_connections[node_a] = {}
	
	_connections[node_a][node_b] = UmlConnection.new(node_a, node_b, connection_type)
	connections_updated.emit()


func _connect_chain(chain: Array[UmlNode], connection_type: UmlConnection.Type) -> void:
	var prev_node
	for node in chain:
		if prev_node:
			_connect(prev_node, node, connection_type)
		prev_node = node
