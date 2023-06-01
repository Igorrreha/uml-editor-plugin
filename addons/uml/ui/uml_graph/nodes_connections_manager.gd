class_name UmlNodesConnectionsManager
extends Node


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


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_C:
			var selected_nodes = _selected_nodes_provider.provide()
			
			if selected_nodes.size() < 2:
				return
			
			if Input.is_action_pressed("1"):
				_connect_chain(selected_nodes, UmlConnection.Type.ASSOCIATION)
			elif Input.is_action_pressed("2"):
				_connect_chain(selected_nodes, UmlConnection.Type.DIRECTED_ASSOCIATION)
			elif Input.is_action_pressed("3"):
				_connect_chain(selected_nodes, UmlConnection.Type.AGGREGATION)
			elif Input.is_action_pressed("4"):
				_connect_chain(selected_nodes, UmlConnection.Type.COMPOSITION)
			elif Input.is_action_pressed("5"):
				_connect_chain(selected_nodes, UmlConnection.Type.INHERITANCE)
			elif Input.is_action_pressed("6"):
				_connect_chain(selected_nodes, UmlConnection.Type.REALIZATION)
			elif Input.is_action_pressed("7"):
				_connect_chain(selected_nodes, UmlConnection.Type.DEPENDENCY)

