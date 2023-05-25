class_name UmlClassNodeArgument
extends HBoxContainer


@export var _default_name: String
@export var _default_type: String


@onready var description: = UmlClassNode.ArgumentDescription.new(_default_name,
		_default_type)
@onready var name_edit: = $Name


func set_argument_name(new_text: String) -> void:
	description.name = new_text


func set_argument_type(new_text: String) -> void:
	description.type = new_text


func _ready() -> void:
	name_edit.text = _default_name
	$Type.text = _default_type


func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		var popup = $PopupMenu as PopupMenu
		popup.popup(Rect2(event.global_position, popup.size))
