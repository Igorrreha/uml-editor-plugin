class_name UmlClassNodeSignal
extends HBoxContainer


@export var _default_name: String
var _arguments: Array[UmlClassNode.ArgumentDescription]

@onready var description: = UmlClassNode.SignalDescription.new(_default_name, _arguments)



func add_argument(argument: UmlClassNode.ArgumentDescription) -> void:
	_arguments.append(argument)
	_on_arguments_changed()


func remove_argument(argument: UmlClassNode.ArgumentDescription) -> void:
	_arguments.remove_at(_arguments.find(argument))
	_on_arguments_changed()


func set_signal_name(new_text: String) -> void:
	description.name = new_text


func _ready() -> void:
	$Name.text = _default_name


func _on_arguments_changed() -> void:
	description.arguments = _arguments


func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		var popup = $PopupMenu as PopupMenu
		popup.popup(Rect2(event.global_position, popup.size))
