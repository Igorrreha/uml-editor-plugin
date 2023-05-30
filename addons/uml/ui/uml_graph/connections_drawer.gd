extends Node


@export var _graph: UmlGraph
@export var _connections_manager: UmlNodesConnectionsManager

@export var connections_settings: Array[UmlConnectionSettings]

@export_group("Line")
@export var _line_width: float
@export var _line_dash: float
@export var _line_color: Color

@export_group("Arrow")
@export_range(0, 360, 1) var _arrow_angle_degrees: float
@export var _arrow_length: float

@export_group("Diamond")
@export_range(0, 360, 1) var _diamond_angle_degrees: float
@export var _diamond_length: float


func on_graph_draw() -> void:
	var connections = _connections_manager.get_connections()
	var zoom = _graph.zoom
	var line_width = _line_width * zoom
	var line_dash = _line_dash * zoom
	
	for connection in connections:
		var node_a = connection.node_a as UmlNode
		var node_b = connection.node_b as UmlNode
		var point_a = node_a.position + node_a.size / 2 * zoom
		var point_b = node_b.position + node_b.size / 2 * zoom
		
		var delta = point_b - point_a
		var delta_angle = delta.angle()
		
		point_a += _get_point_on_rect(node_a.get_rect(), delta_angle)
		point_b -= _get_point_on_rect(node_b.get_rect(), delta_angle)
		_draw_connection(connection.type, point_a, point_b, _line_color, line_width, line_dash)


func _draw_connection(type: UmlConnection.Type, from: Vector2, to: Vector2,
		color: Color, line_width: float, line_dash: float) -> void:
	var connection_settings = connections_settings.filter(func(settings: UmlConnectionSettings):
		return settings.type == type)
	
	if connection_settings.is_empty():
		printerr("Can't find settings for connection %s" % UmlConnection.Type.find_key(type))
		return
	
	var settings = connection_settings[0] as UmlConnectionSettings
	match settings.line_type:
		UmlConnection.LineType.STRAIGHT:
			_graph.draw_line(from, to, color, line_width)
		UmlConnection.LineType.DASHED:
			_graph.draw_dashed_line(from, to, color, line_width, line_dash)
	
	var delta = to - from
	var delta_angle = delta.angle()
	match settings.head_type:
		UmlConnection.HeadType.OPENED_ARROW:
			_draw_arrow_head(to, delta_angle, _graph.zoom)
		UmlConnection.HeadType.ARROW:
			_draw_arrow_head(to, delta_angle, _graph.zoom, true)
		UmlConnection.HeadType.FILLED_ARROW:
			_draw_arrow_head(to, delta_angle, _graph.zoom, true, true)
		UmlConnection.HeadType.DIAMOND:
			_draw_diamond_head(to, delta_angle, _graph.zoom)
		UmlConnection.HeadType.FILLED_DIAMOND:
			_draw_diamond_head(to, delta_angle, _graph.zoom, true)


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


func _draw_arrow_head(target: Vector2, angle: float, zoom: float,
		closed: bool = false, filled: bool = false) -> void:
	var angle_vector = Vector2.from_angle(angle)
	var tail_delta = angle_vector * -_arrow_length * zoom
	
	var line_width = _line_width * zoom
	
	var point_a = target + tail_delta.rotated(deg_to_rad(_arrow_angle_degrees / 2))
	_graph.draw_line(target, point_a, _line_color, line_width)
	
	var point_b = target + tail_delta.rotated(deg_to_rad(-_arrow_angle_degrees / 2))
	_graph.draw_line(target, point_b, _line_color, line_width)
	
	if closed or filled:
		_graph.draw_line(point_a, point_b, _line_color, line_width)
	
	if filled:
		_graph.draw_colored_polygon([target, point_a, point_b], _line_color)


func _draw_diamond_head(target: Vector2, angle: float, zoom: float,
		filled: bool = false) -> void:
	var angle_vector = Vector2.from_angle(angle)
	var tail_delta = angle_vector * -_diamond_length * zoom
	
	var line_width = _line_width * zoom
	
	var point_a = target + tail_delta.rotated(deg_to_rad(_diamond_angle_degrees / 2)) / 2
	var point_b = target + tail_delta
	var point_c = target + tail_delta.rotated(deg_to_rad(-_diamond_angle_degrees / 2)) / 2
	
	var polygon_points = [target, point_a, point_b, point_c, target]
	_graph.draw_polyline(polygon_points, _line_color, line_width)
	
	if filled:
		_graph.draw_colored_polygon(polygon_points, _line_color)
