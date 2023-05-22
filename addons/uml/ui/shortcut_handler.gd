extends Control


signal shortcut_handled


@export var _shortcut: Shortcut


func _shortcut_input(event: InputEvent) -> void:
	if _shortcut.matches_event(event):
		shortcut_handled.emit()
