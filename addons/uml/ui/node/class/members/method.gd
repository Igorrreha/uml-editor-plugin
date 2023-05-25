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


func _ready() -> void:
	$AccessModifier.selected = _default_access_modifier
	$Name.text = _default_name
	$Type.text = _default_type


func _on_access_modifier_selected(modifier: UmlClassNode.AccessModifier) -> void:
	description.access_modifier = modifier


func _on_name_text_changed(new_text: String) -> void:
	description.name = new_text


func _on_type_text_changed(new_text: String) -> void:
	description.return_type = new_text


func _on_arguments_changed() -> void:
	description.arguments = _arguments
