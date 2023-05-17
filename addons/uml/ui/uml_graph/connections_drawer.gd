extends Node


@export var _graph: UmlGraph


func on_graph_draw() -> void:
	var connections = _graph.get_connections()
	
	for connection in connections:
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
		
		_graph.draw_line(point_a, point_b, Color.CORAL, 5)
