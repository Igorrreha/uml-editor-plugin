class_name UmlClassNodeVariable
extends UmlClassNodeMember


@export var _default_access_modifier: Uml.ClassMemberAccessModifier
@export var _default_name: String
@export var _default_type: String

@onready var _description: = UmlVariableDescription.new(_default_access_modifier,
		_default_name, _default_type)


func get_description() -> UmlVariableDescription:
	return _description


func set_access_modifier(modifier: Uml.ClassMemberAccessModifier) -> void:
	_description.access_modifier = modifier


func set_variable_name(new_text: String) -> void:
	_description.name = new_text


func set_variable_type(new_text: String) -> void:
	_description.type = new_text


func _ready() -> void:
	$AccessModifier.selected = _default_access_modifier
	$Name.text = _default_name
	$Type.text = _default_type


func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_RIGHT
	and event.is_pressed()):
		var popup = $PopupMenu as PopupMenu
		popup.popup(Rect2(event.global_position, popup.size))
