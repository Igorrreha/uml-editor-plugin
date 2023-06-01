extends MenuButton


signal connection_type_selected(type: UmlConnection.Type)

@onready var _popup: = get_popup()


func _ready() -> void:
	_popup.window_input.connect(_on_popup_window_input)
	_popup.index_pressed.connect(_on_popup_window_idx_pressed)
	_create_popup_items()


func _create_popup_items() -> void:
	var idx = -1
	for connection in UmlConnection.Type:
		idx += 1
		_popup.add_item(connection)
		
		var shortcut_event = InputEventKey.new()
		shortcut_event.key_label = KEY_1 + idx
		shortcut_event.physical_keycode = KEY_1 + idx
		shortcut_event.keycode = KEY_1 + idx
		shortcut_event.pressed = false
		
		var shortcut = Shortcut.new()
		shortcut.events.append(shortcut_event)
		print(shortcut.has_valid_event())
		_popup.set_item_shortcut(idx, shortcut)
		shortcut_feedback


func _on_popup_window_idx_pressed(idx: int) -> void:
	connection_type_selected.emit(idx)


func _on_popup_window_input(event: InputEvent) -> void:
	for item_idx in range(_popup.item_count):
		var item_shortcut = _popup.get_item_shortcut(item_idx)
		if item_shortcut.matches_event(event):
			_popup.set_focused_item(item_idx)
			return
