class_name UmlGraph
extends GraphEdit


@export var _popup_menu: PopupMenu

var _connections: Array[Connection] = []


func get_connections() -> Array[Connection]:
	return _connections


func _on_popup_request(position) -> void:
	_popup_menu.popup(Rect2(position, _popup_menu.size))


func _connect(node_a: UmlNode, node_b: UmlNode) -> void:
	_connections.append(Connection.new(node_a, node_b))


func _input(event) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_C:
			var selected_nodes = get_children().filter(func(child):
				return child is UmlNode and child.selected)
			
			var prev_node: UmlNode
			for node in selected_nodes:
				if prev_node:
					_connect(prev_node, node)
				
				prev_node = node
			
			queue_redraw()


class Connection:
	var node_a: UmlNode
	var node_b: UmlNode
	
	func _init(node_a: UmlNode, node_b: UmlNode):
		self.node_a = node_a
		self.node_b = node_b
