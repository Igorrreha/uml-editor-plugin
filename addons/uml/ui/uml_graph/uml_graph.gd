class_name UmlGraph
extends GraphEdit


@export var _popup_menu: PopupMenu


func _on_popup_request(position) -> void:
	_popup_menu.popup(Rect2(position, _popup_menu.size))


func _input(event) -> void:
	pass
