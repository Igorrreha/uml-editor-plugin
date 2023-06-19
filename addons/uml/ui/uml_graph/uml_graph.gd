class_name UmlGraph
extends GraphEdit


@export var _popup_menu: PopupMenu

var _description: UmlGraphDescription
var _changes_description: UmlGraphDescription 


func _on_popup_request(position) -> void:
	_popup_menu.popup(Rect2(position + global_position, _popup_menu.size))
