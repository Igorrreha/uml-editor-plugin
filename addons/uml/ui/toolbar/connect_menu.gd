extends MenuButton


func _ready() -> void:
	var popup = get_popup()
	
	var idx = -1
	for connection in UmlConnection.Type:
		idx += 1
		popup.add_item(connection)
		
		var shortcut_event = InputEventKey.new()
		shortcut_event.key_label = KEY_0 + idx
		shortcut_event.physical_keycode = KEY_0 + idx
		shortcut_event.keycode = KEY_0 + idx
		
		var shortcut = Shortcut.new()
		shortcut.events.append(shortcut_event)
		popup.set_item_shortcut(idx, shortcut)
		print(popup.is_processing_shortcut_input())
		popup.set_process_shortcut_input(true)
	
	
	popup.id_pressed.connect(_on_id_pressed)


func _on_id_pressed(id: int):
	print(id)
