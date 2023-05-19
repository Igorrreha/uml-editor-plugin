class_name UmlGraph
extends GraphEdit


@export var _popup_menu: PopupMenu

var _connections: Array[Connection] = []


enum ConnectionType {
	ASSOCIATION,
	DIRECTED_ASSOCIATION,
	COMPOSITION,
	INHERITANCE,
	REALIZATION,
}


func get_connections() -> Array[Connection]:
	return _connections


func _on_popup_request(position) -> void:
	_popup_menu.popup(Rect2(position, _popup_menu.size))


func _connect(node_a: UmlNode, node_b: UmlNode, connection_type: ConnectionType) -> void:
	_connections.append(Connection.new(node_a, node_b, connection_type))


func _input(event) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_C:
			var selected_nodes = get_children().filter(func(child):
				return child is UmlNode and child.selected)
			
			var prev_node: UmlNode
			for node in selected_nodes:
				if prev_node:
					if Input.is_action_pressed("1"):
						_connect(prev_node, node, ConnectionType.ASSOCIATION)
					elif Input.is_action_pressed("2"):
						_connect(prev_node, node, ConnectionType.DIRECTED_ASSOCIATION)
					elif Input.is_action_pressed("3"):
						_connect(prev_node, node, ConnectionType.COMPOSITION)
					elif Input.is_action_pressed("4"):
						_connect(prev_node, node, ConnectionType.INHERITANCE)
					elif Input.is_action_pressed("5"):
						_connect(prev_node, node, ConnectionType.REALIZATION)
				
				prev_node = node
			
			queue_redraw()


class Connection:
	var node_a: UmlNode
	var node_b: UmlNode
	var type: ConnectionType
	
	func _init(node_a: UmlNode, node_b: UmlNode, connection_type: ConnectionType):
		self.node_a = node_a
		self.node_b = node_b
		self.type = connection_type
