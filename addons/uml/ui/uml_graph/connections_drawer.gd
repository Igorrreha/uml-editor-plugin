extends Node


@export var _graph: UmlGraph

@export_group("Line")
@export var _line_width: float
@export var _line_color: Color

@export_group("Heading")
@export_range(0, 360, 1) var _heading_angle_degrees: float
@export var _heading_length: float


func on_graph_draw() -> void:
	var connections = _graph.get_connections()
	
	for connection in connections:
		var node_a = connection.node_a as UmlNode
		var node_b = connection.node_b as UmlNode
		var point_a = node_a.position + node_a.size / 2
		var point_b = node_b.position + node_b.size / 2
		
		var delta = point_b - point_a
		var delta_angle = delta.angle()
		
		point_a += _get_point_on_rect(node_a.get_rect(), delta_angle)
		point_b -= _get_point_on_rect(node_b.get_rect(), delta_angle)
		
		match connection.type:
			UmlGraph.ConnectionType.ASSOCIATION:
				_graph.draw_line(point_a, point_b, _line_color, _line_width)
			
			UmlGraph.ConnectionType.DIRECTED_ASSOCIATION:
				_graph.draw_line(point_a, point_b, _line_color, _line_width)
				_draw_arrow_heading(point_b, delta_angle, true, true)
			
			UmlGraph.ConnectionType.COMPOSITION:
				_graph.draw_line(point_a, point_b, _line_color, _line_width)
				_draw_diamond_heading(point_b, delta_angle, true)
			
			UmlGraph.ConnectionType.INHERITANCE:
				_graph.draw_line(point_a, point_b, _line_color, _line_width)
				_draw_arrow_heading(point_b, delta_angle, true, false)
			
			UmlGraph.ConnectionType.REALIZATION:
				_graph.draw_dashed_line(point_a, point_b, _line_color, _line_width, 10)
				_draw_arrow_heading(point_b, delta_angle, true, false)


func _get_point_on_rect(rect: Rect2, angle: float) -> Vector2:
	var angle_vector = Vector2.from_angle(angle)
	var center = rect.size / 2
	
	var angle_ratio = abs(sin(center.angle()))
	var delta_angle_ratio = abs(sin(angle))
	
	var angle_to_right = angle_vector.angle_to(Vector2.RIGHT)
	if delta_angle_ratio < angle_ratio:
		return (center.x / cos(angle_to_right) * angle_vector
			* (1 if angle_vector.x > 0 else -1))
	
	var angle_to_down = angle_vector.angle_to(Vector2.DOWN)
	if delta_angle_ratio > angle_ratio:
		return (center.y / cos(angle_to_down) * angle_vector
			* (1 if angle_vector.y > 0 else -1))
	
	return Vector2.ZERO


func _draw_arrow_heading(target: Vector2, angle: float, closed: bool = false,
		filled: bool = false) -> void:
	var angle_vector = Vector2.from_angle(angle)
	var tail_delta = angle_vector * -_heading_length
	
	var point_a = target + tail_delta.rotated(deg_to_rad(_heading_angle_degrees))
	_graph.draw_line(target, point_a, _line_color, _line_width)
	
	var point_b = target + tail_delta.rotated(deg_to_rad(-_heading_angle_degrees))
	_graph.draw_line(target, point_b, _line_color, _line_width)
	
	if closed or filled:
		_graph.draw_line(point_a, point_b, _line_color, _line_width)
	
	if filled:
		_graph.draw_colored_polygon([target, point_a, point_b], _line_color)


func _draw_diamond_heading(target: Vector2, angle: float, filled: bool = false) -> void:
	_draw_arrow_heading(target, angle, filled, filled)
	
	var heading_midline_length = cos(deg_to_rad(_heading_angle_degrees)) * _heading_length
	var diamond_midline_vector = Vector2.from_angle(angle) * heading_midline_length * 2
	_draw_arrow_heading(target - diamond_midline_vector, angle + PI, filled, filled)
