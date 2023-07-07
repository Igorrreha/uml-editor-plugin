class_name UmlClassNodeTitleEditor
extends Node


signal opened
signal class_name_edit_text_changed(text: String)
signal parent_class_name_edit_text_changed(text: String)


@export var _target_node: UmlNode
@export var _editing_popup: Popup
@export var _edits_container: Control
@export var _class_name_edit: LineEdit
@export var _parent_class_name_edit: LineEdit

var _is_parent_class_locked: bool


var _self_class_name_handler: ReactiveResource.PropertyHandler
var _parent_class_name_handler: ReactiveResource.PropertyHandler


func setup(self_class_name_handler: ReactiveResource.PropertyHandler,
		parent_class_name_handler: ReactiveResource.PropertyHandler) -> void:
	_remove_reactive_callbacks()
	
	_self_class_name_handler = self_class_name_handler
	_parent_class_name_handler = parent_class_name_handler
	
	_self_class_name_handler.bind(_on_self_class_name_update_handled,
		_on_class_name_edit_text_changed)
	_parent_class_name_handler.bind(_on_parent_class_name_update_handled,
		_on_parent_class_name_edit_text_changed)
	
	_on_self_class_name_update_handled()
	_on_parent_class_name_update_handled()


func _exit_tree() -> void:
	_remove_reactive_callbacks()


func _remove_reactive_callbacks() -> void:
	if _self_class_name_handler:
		_self_class_name_handler.remove_callback(_on_self_class_name_update_handled)
	if _parent_class_name_handler:
		_parent_class_name_handler.remove_callback(_on_parent_class_name_update_handled)


func _on_self_class_name_update_handled() -> void:
	var actual_value = _self_class_name_handler.get_value()
	_class_name_edit.text = actual_value
	_target_node.title = actual_value
	class_name_edit_text_changed.emit(actual_value)


func _on_parent_class_name_update_handled() -> void:
	var actual_value = _parent_class_name_handler.get_value()
	_parent_class_name_edit.text = actual_value
	_update_parent_class_state()
	parent_class_name_edit_text_changed.emit(actual_value)


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
	_self_class_name_handler.set_value(text, _on_class_name_edit_text_changed)


func _on_parent_class_name_edit_text_changed(text: String) -> void:
	parent_class_name_edit_text_changed.emit(text)
	_parent_class_name_handler.set_value(text, _on_parent_class_name_edit_text_changed)


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
