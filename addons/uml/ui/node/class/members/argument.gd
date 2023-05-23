class_name UmlClassNodeArgument
extends HBoxContainer


@export var _default_name: String
@export var _default_type: String


@onready var description: = UmlClassNode.ArgumentDescription.new(_default_name,
		_default_type)
@onready var name_edit: = $Name


func _ready() -> void:
	name_edit.text = _default_name
	$Type.text = _default_type


func _on_name_text_changed(new_text: String) -> void:
	description.name = new_text


func _on_type_text_changed(new_text: String) -> void:
	description.type = new_text


func _on_focus_exited() -> void:
	if name_edit.text == "":
		queue_free()
