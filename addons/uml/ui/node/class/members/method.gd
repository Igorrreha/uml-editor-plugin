class_name UmlClassNodeMethod
extends HBoxContainer


@export var _default_access_modifier: UmlClassNode.AccessModifier
@export var _default_name: String
@export var _default_type: String
var _arguments: Array[UmlClassNode.ArgumentDescription]

@onready var description: = UmlClassNode.MethodDescription.new(_default_access_modifier,
		_default_name, _default_type, _arguments)


func add_argument(argument: UmlClassNode.ArgumentDescription) -> void:
	_arguments.append(argument)
	_on_arguments_changed()


func remove_argument(argument: UmlClassNode.ArgumentDescription) -> void:
	_arguments.remove_at(_arguments.find(argument))
	_on_arguments_changed()


func set_access_modifier(modifier: UmlClassNode.AccessModifier) -> void:
	description.access_modifier = modifier


func set_method_name(new_text: String) -> void:
	description.name = new_text


func set_return_type(new_text: String) -> void:
	description.return_type = new_text


func _ready() -> void:
	$AccessModifier.selected = _default_access_modifier
	$Name.text = _default_name
	$Type.text = _default_type


func _on_arguments_changed() -> void:
	description.arguments = _arguments


func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		var popup = $PopupMenu as PopupMenu
		popup.popup(Rect2(event.global_position, popup.size))
