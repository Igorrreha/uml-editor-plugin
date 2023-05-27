extends Node


@export var _target: UmlClassNode
@export var _icon_scale: Vector2 = Vector2.ONE
var _icon: Texture2D


var _draw_outside: bool


func update_icon(new_class_name: String) -> void:
	_icon = ClassIconsProvider.get_icon(new_class_name)
	draw_outside()


func draw():
	if not _icon:
		return
	
	var size = _target.HEADER_HEIGHT * _icon_scale
	
	var position = Vector2(1, 0) * _target.size
	var offset = (Vector2.ONE - _icon_scale) / 2 * _target.HEADER_HEIGHT
	position += offset
	
	if not _draw_outside:
		position += _target.HEADER_HEIGHT * Vector2(-1, 0)
	
	_target.draw_texture_rect(_icon, Rect2(position, size), false)
	_draw_outside = false


func draw_outside() -> void:
	_draw_outside = true
	_target.queue_redraw()
