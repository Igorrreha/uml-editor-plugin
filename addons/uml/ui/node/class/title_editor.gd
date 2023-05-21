extends Node


@export var _class_node: UmlNode
@export var _editing_popup: Popup
@export var _title_line_edit: LineEdit


func _on_class_node_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.position.y > _class_node.HEADER_HEIGHT:
			return
		
		if event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
			var popup_position = _class_node.global_position
			var popup_size = Vector2(_class_node.size.x, _class_node.HEADER_HEIGHT)
			
			_title_line_edit.text = _class_node.title
			_editing_popup.popup(Rect2(popup_position, popup_size))


func _on_editing_popup_hide() -> void:
	_class_node.title = _title_line_edit.text
