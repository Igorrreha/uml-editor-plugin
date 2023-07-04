class_name UmlClassNodeMembersContainer
extends VBoxContainer


@export var _tscn_member: PackedScene
@export var _add_member_button: Button

var _state: UmlClassState


func setup(content: UmlClassState) -> void:
	pass


func add_member() -> void:
	var new_member = _tscn_member.instantiate()
	add_child(new_member)
	_on_member_added(new_member)


func _ready() -> void:
	_update_add_member_button_visibility()


func _on_member_added(node: Node) -> void:
	if not node != _add_member_button:
		node.tree_exited.connect(_on_member_removed.bind(node))
		_update_add_member_button_visibility()
		_on_membership_updated()


func _on_member_removed(node: Node) -> void:
	if node != _add_member_button:
		node.tree_exited.disconnect(_on_member_removed)
		_update_add_member_button_visibility()
		_on_membership_updated()


func _on_membership_updated() -> void:
	pass


func _update_add_member_button_visibility() -> void:
	_add_member_button.visible = not get_children().any(func(child: Node):
		return child != _add_member_button)
