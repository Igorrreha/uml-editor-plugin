class_name UmlClassNodeMembersContainer
extends VBoxContainer


@export var _tscn_member: PackedScene
@export var _add_member_button: Button

var _state: UmlClassState


func setup(content: UmlClassState) -> void:
	pass


func _ready() -> void:
	_update_add_member_button_visibility()


func _add_members(states: Array) -> void:
	for state in states:
		_add_member(state, true)
	
	_on_membership_updated()


func _add_member(state: ReactiveResource, silent: bool = false) -> void:
	var new_member = _tscn_member.instantiate() as UmlClassNodeMember
	add_child(new_member)
	new_member.asked_to_be_removed.connect(_on_member_asked_to_be_removed.bind(new_member))
	new_member.setup(state)
	
	if not silent:
		_on_membership_updated()


func _on_member_asked_to_be_removed(node: UmlClassNodeMember) -> void:
	pass


func _remove_members(states: Array) -> void:
	var children_to_remove = get_children().filter(func(child):
		return child is UmlClassNodeMember and states.has(child.state))
	
	for child in children_to_remove:
		_remove_member(child, true)
	
	_on_membership_updated()


func _remove_member(child: UmlClassNodeMember, silent = false) -> void:
	child.asked_to_be_removed.disconnect(_on_member_asked_to_be_removed)
	remove_child(child)
	
	if not silent:
		_on_membership_updated()


func _on_membership_updated() -> void:
	_update_add_member_button_visibility()


func _update_add_member_button_visibility() -> void:
	_add_member_button.visible = not get_children().any(func(child):
		return child is UmlClassNodeMember)
