extends GraphEdit


@export var _popup_menu: PopupMenu

var _connections: Array[Connection] = []


func _on_popup_request(position) -> void:
	_popup_menu.popup(Rect2(position, _popup_menu.size))


func _draw() -> void:
	_draw_connections()


func _draw_connections() -> void:
	for connection in _connections:
		var node_a = connection.node_a
		var node_b = connection.node_b
		var point_a = node_a.position + node_a.size / 2
		var point_b = node_b.position + node_b.size / 2
		
		var delta = point_b - point_a
		var ratio_angle_a = abs(sin(node_a.size.angle()))
		var delta_angle_ratio = abs(sin(delta.angle()))
		prints(ratio_angle_a, abs(sin(delta.angle())))
		
		var delta_cut_a: float
		if delta_angle_ratio > ratio_angle_a:
			delta_cut_a = cos(delta.angle()) * node_a.size.y / 2
		else:
			delta_cut_a = cos(delta.angle()) * node_a.size.x / 2
		
		prints(delta.angle(), delta_cut_a)
		point_a += delta.normalized() * delta_cut_a
		
		draw_line(point_a, point_b, Color.CORAL, 5)


func _connect(node_a: UmlNode, node_b: UmlNode) -> void:
	_connections.append(Connection.new(node_a, node_b))


func _input(event) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_C:
			var selected_nodes = get_children().filter(func(child: UmlNode):
				return child and child.selected)
			
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
