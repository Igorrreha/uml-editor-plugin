extends Control


signal icon_updated(new_icon: Texture2D)


@export var _target: UmlClassNode
@export var _target_unit_position: Vector2 
@export var _can_be_drawn_inside: bool

@export var _icon_scale: Vector2 = Vector2.ONE

@export var _fallback_icon: Texture2D
var _icon: Texture2D


var _draw_outside: bool


func set_fallback_icon(icon: Texture2D) -> void:
	_fallback_icon = icon
	draw_outside()


func update_icon(new_class_name: String) -> void:
	_icon = ClassIconsProvider.get_icon(new_class_name)
	icon_updated.emit(_icon)
	draw_outside()


func draw_outside() -> void:
	_draw_outside = true
	queue_redraw()


func _draw():
	var icon = _icon if _icon else _fallback_icon
	if (not icon
	or (not _draw_outside and not _can_be_drawn_inside)):
		return
	
	var size = _target.HEADER_HEIGHT * _icon_scale
	
	var draw_position = _target_unit_position * Vector2(_target.size.x, _target.HEADER_HEIGHT)
	var offset = (Vector2.ONE - _icon_scale) / 2 * _target.HEADER_HEIGHT
	draw_position += offset
	
	if not _draw_outside:
		draw_position += _target.HEADER_HEIGHT * Vector2(-1, 0)
	
	draw_texture_rect(icon, Rect2(draw_position - position, size), false)
	_draw_outside = false
