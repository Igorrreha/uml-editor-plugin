extends Node


signal opened()
signal title_changed(text: String)

@export var _target_node: UmlNode
@export var _editing_popup: Popup
@export var _edits_container: Control
@export var _title_edit: LineEdit


func on_target_node_gui_input(event: InputEvent) -> void:
	if (not event is InputEventMouseButton
	or event.position.y > _target_node.HEADER_HEIGHT
	or (event.button_index != MOUSE_BUTTON_LEFT or not event.double_click)
	or _edits_container.get_child_count() == 0):
		return
	
	var popup_position = _target_node.global_position
	
	var childs_count = _edits_container.get_child_count()
	var child_size = Vector2(_target_node.size.x, _target_node.HEADER_HEIGHT)
	var popup_size = child_size * Vector2(1, childs_count)
	
	_edits_container.size = popup_size
	_edits_container.scale = _target_node.scale
	
	_title_edit.text = _target_node.title
	
	_editing_popup.popup(Rect2(popup_position, popup_size * _target_node.scale))
	opened.emit()


func _on_editing_popup_hide() -> void:
	_target_node.title = _title_edit.text


func _on_title_edit_text_changed(text: String) -> void:
	title_changed.emit(text)
