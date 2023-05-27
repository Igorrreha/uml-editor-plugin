extends Node


signal opened()
signal class_name_edit_text_changed(text: String)
signal parent_class_name_edit_text_changed(text: String)


@export var _target_node: UmlNode
@export var _editing_popup: Popup
@export var _edits_container: Control
@export var _class_name_edit: LineEdit
@export var _parent_class_name_edit: LineEdit

var _is_parent_class_locked: bool


func on_target_node_gui_input(event: InputEvent) -> void:
	if (not event is InputEventMouseButton
	or event.position.y > _target_node.HEADER_HEIGHT
	or (event.button_index != MOUSE_BUTTON_LEFT or not event.double_click)):
		return
	
	var popup_position = _target_node.global_position
	
	var childs_count = 2
	var child_size = Vector2(_target_node.size.x, _target_node.HEADER_HEIGHT)
	var popup_size = child_size * Vector2(1, childs_count)
	
	_edits_container.size = popup_size
	_edits_container.scale = _target_node.scale
	
	_class_name_edit.text = _target_node.title
	
	_editing_popup.popup(Rect2(popup_position, popup_size * _target_node.scale))
	opened.emit()


func _set_current_class_as_parent() -> void:
	_parent_class_name_edit.text = _class_name_edit.text
	_on_parent_class_name_edit_text_changed(_class_name_edit.text)


func _on_editing_popup_hide() -> void:
	_target_node.title = _class_name_edit.text


func _on_class_name_edit_text_changed(text: String) -> void:
	class_name_edit_text_changed.emit(text)
	_update_parent_class_state()


func _on_parent_class_name_edit_text_changed(text: String) -> void:
	parent_class_name_edit_text_changed.emit(text)


func _set_parent_class_lock(locked: bool) -> void:
	_is_parent_class_locked = locked
	_parent_class_name_edit.editable = not locked


func _update_parent_class_state() -> void:
	var cur_class = _class_name_edit.text
	
	var parent_class: String
	if ClassDB.class_exists(cur_class):
		_set_parent_class_lock(true)
		parent_class = ClassDB.get_parent_class(cur_class)
	
	else:
		_set_parent_class_lock(false)
		var class_descriptions = (ProjectSettings.get_global_class_list()
			.filter(func(class_description):
				return class_description["class"] == cur_class))
		
		if class_descriptions.is_empty():
			return
		
		parent_class = class_descriptions[0]["base"]
	
	_parent_class_name_edit.text = parent_class
	_on_parent_class_name_edit_text_changed(parent_class)
