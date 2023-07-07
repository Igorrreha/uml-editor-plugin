class_name UmlClassNodeMembersContainer
extends ReactiveCollectionContainer


@export var _add_member_button: Button


func _ready() -> void:
	_update_add_member_button_visibility()


func _after_state_updated() -> void:
	_update_add_member_button_visibility()


func _update_add_member_button_visibility() -> void:
	_add_member_button.visible = _state.is_empty()
