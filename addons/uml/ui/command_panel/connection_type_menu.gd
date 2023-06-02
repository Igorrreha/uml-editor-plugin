extends MenuButton


signal connection_type_selected(type: UmlConnection.Type)


@export var _items_priority: Array[UmlConnection.Type]

@onready var _popup: = get_popup()


func _ready() -> void:
	_popup.window_input.connect(_on_popup_window_input)
	_popup.id_pressed.connect(_on_popup_window_id_pressed)
	_create_popup_items()


func _create_popup_items() -> void:
	var idx = -1
	
	for type_value in _items_priority:
		idx += 1
		var type_name = UmlConnection.Type.find_key(type_value)
		_create_popup_item(idx, type_value, type_name)
	
	for type_name in UmlConnection.Type:
		var type_value = UmlConnection.Type.get(type_name)
		
		if _items_priority.has(type_value):
			continue
		
		idx += 1
		_create_popup_item(idx, type_value, type_name)


func _create_popup_item(idx: int, id: int, title: String) -> void:
	_popup.add_item(title, id)
	
	var shortcut_event = InputEventKey.new()
	shortcut_event.key_label = KEY_1 + idx
	shortcut_event.physical_keycode = KEY_1 + idx
	shortcut_event.keycode = KEY_1 + idx
	shortcut_event.pressed = false
	
	var shortcut = Shortcut.new()
	shortcut.events.append(shortcut_event)
	_popup.set_item_shortcut(idx, shortcut)
	shortcut_feedback


func _on_popup_window_id_pressed(id: int) -> void:
	connection_type_selected.emit(id)


func _on_popup_window_input(event: InputEvent) -> void:
	for item_idx in range(_popup.item_count):
		var item_shortcut = _popup.get_item_shortcut(item_idx)
		if item_shortcut.matches_event(event):
			_popup.set_focused_item(item_idx)
			return
