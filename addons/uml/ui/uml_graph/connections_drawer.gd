extends Node


@export var _graph: UmlGraph

@export_group("Line")
@export var _line_width: float
@export var _line_color: Color

@export_group("Heading")
@export_range(0, 360, 1) var _heading_angle: float
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
		
		_graph.draw_line(point_a, point_b, _line_color, _line_width)
		_draw_arrow_heading(point_b, delta_angle)


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


func _draw_arrow_heading(target: Vector2, angle: float) -> void:
	var angle_vector = Vector2.from_angle(angle)
	var tail_delta = angle_vector * -_heading_length
	_graph.draw_line(target, target + tail_delta.rotated(deg_to_rad(_heading_angle)),
			_line_color, _line_width)
	_graph.draw_line(target, target + tail_delta.rotated(deg_to_rad(-_heading_angle)),
			_line_color, _line_width)
