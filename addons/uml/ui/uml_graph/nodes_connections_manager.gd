class_name UmlNodesConnectionsManager
extends Node


enum ConnectionsRemovingType {
	SELECTED_CHAIN,
	ALL,
	ALL_IN,
	ALL_OUT,
}


signal connections_updated()


@export var _selected_nodes_provider: UmlSelectedNodesProvider

var _connections: Dictionary: #[UmlNode, Dictionary[UmlNode, UmlConnection]]
	set(v):
		_connections_list_is_actual = false
		_cross_connections_is_actual = false
		_connections = v

var _connections_list: Array[UmlConnection]
var _connections_list_is_actual: bool

var _cross_connections: Array[UmlConnection]
var _cross_connections_is_actual: bool


func get_connections() -> Array[UmlConnection]:
	if not _connections_list_is_actual:
		_actualize_connections_list()
		_connections_list_is_actual = true
	
	return _connections_list


func get_cross_connections() -> Array[UmlConnection]:
	if not _cross_connections_is_actual:
		_actualize_cross_connections()
		_cross_connections_is_actual = true
	
	return _cross_connections


func connect_selected_nodes(connection_type: UmlConnection.Type) -> void:
	var selected_nodes = _selected_nodes_provider.provide()
	if selected_nodes.size() < 2:
		return
	
	_connect_chain(selected_nodes, connection_type)


func remove_selected_connections(removing_type: ConnectionsRemovingType) -> void:
	var selected_nodes = _selected_nodes_provider.provide()
	var connections_to_remove: Array[UmlConnection]
	
	match removing_type:
		ConnectionsRemovingType.SELECTED_CHAIN:
			connections_to_remove = _get_selected_chain_connections()
		
		ConnectionsRemovingType.ALL:
			connections_to_remove = _get_all_selected_nodes_connections()
		
		ConnectionsRemovingType.ALL_IN:
			connections_to_remove = _get_all_selected_nodes_in_connections()
			
		ConnectionsRemovingType.ALL_OUT:
			connections_to_remove = _get_all_selected_nodes_out_connections()
	
	for connection in connections_to_remove:
		_connections[connection.node_a].erase(connection.node_b)
	
	_connections_list_is_actual = false
	_cross_connections_is_actual = false
	connections_updated.emit()


func _get_selected_chain_connections() -> Array[UmlConnection]:
	var connections: Array[UmlConnection]
	var prev_node: UmlNode
	for node in _selected_nodes_provider.provide():
		if (prev_node
		and _connections.has(prev_node)
		and _connections[prev_node].has(node)):
			connections.append(_connections[prev_node][node])
		
		prev_node = node
	
	return connections


func _get_all_selected_nodes_connections() -> Array[UmlConnection]:
	var in_connections = _get_all_selected_nodes_in_connections()
	var out_connections = _get_all_selected_nodes_out_connections()
	
	var connections = in_connections.duplicate()
	for connection in out_connections:
		if not connections.has(connection):
			connections.append(connection)
	
	return connections 


func _get_all_selected_nodes_in_connections() -> Array[UmlConnection]:
	var connections: Array[UmlConnection]
	var all_connections_list = get_connections()
	for node in _selected_nodes_provider.provide():
		var in_connections = all_connections_list.filter(func(connection: UmlConnection):
			return connection.node_b == node)
		connections.append_array(in_connections)
	
	return connections


func _get_all_selected_nodes_out_connections() -> Array[UmlConnection]:
	var connections: Array[UmlConnection]
	for node in _selected_nodes_provider.provide():
		if _connections.has(node):
			connections.append_array(_connections[node].values())
	
	return connections


func _actualize_connections_list() -> void:
	_connections_list = []
	for group in _connections.values():
		_connections_list.append_array(group.values())
	
	_connections_list.make_read_only()


func _actualize_cross_connections() -> void:
	_cross_connections = []
	for node_from in _connections:
		for node_to in _connections[node_from]:
			if (_connections.has(node_to)
			and _connections[node_to].has(node_from)):
				_cross_connections.append(_connections[node_from][node_to])
	
	_cross_connections.make_read_only()


func _connect(node_a: UmlNode, node_b: UmlNode, connection_type: UmlConnection.Type) -> void:
	if not _connections.has(node_a):
		_connections[node_a] = {}
	
	_connections[node_a][node_b] = UmlConnection.new(node_a, node_b, connection_type)
	
	_connections_list_is_actual = false
	_cross_connections_is_actual = false
	connections_updated.emit()


func _connect_chain(chain: Array[UmlNode], connection_type: UmlConnection.Type) -> void:
	var prev_node
	for node in chain:
		if prev_node:
			_connect(prev_node, node, connection_type)
		prev_node = node
