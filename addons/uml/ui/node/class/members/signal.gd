class_name UmlClassNodeSignal
extends HBoxContainer


@export var _default_name: String
var _arguments: Array[UmlClassNode.ArgumentDescription]

@onready var description: = UmlClassNode.SignalDescription.new(_default_name, _arguments)



func add_argument(argument: UmlClassNode.ArgumentDescription) -> void:
	_arguments.append(argument)


func remove_argument(argument: UmlClassNode.ArgumentDescription) -> void:
	_arguments.remove_at(_arguments.find(argument))


func _ready() -> void:
	$Name.text = _default_name


func _on_name_text_changed(new_text: String) -> void:
	description.name = new_text


func _on_arguments_changed(args: Array[UmlClassNode.ArgumentDescription]) -> void:
	description.arguments = args
