class_name UmlClassNodeMembersContainer
extends VBoxContainer


@export var _tscn_variable: PackedScene
@export var _add_variable_button: Button


signal signal_added(description: UmlClassNode.SignalDescription)
signal variable_added(description: UmlClassNode.VariableDescription)
signal method_added(description: UmlClassNode.MethodDescription)

signal signal_removed(description: UmlClassNode.SignalDescription)
signal variable_removed(description: UmlClassNode.VariableDescription)
signal method_removed(description: UmlClassNode.MethodDescription)


func add_variable() -> void:
	var new_variable = _tscn_variable.instantiate()
	add_child(new_variable)
	_on_member_added(new_variable)


func _ready() -> void:
	for child in get_children():
		_on_member_added(child)
	
	_update_add_variable_button_visibility()


func _on_member_added(node: Node) -> void:
	if node is UmlClassNodeVariable:
		variable_added.emit(node.description)
		node.tree_exited.connect(_on_child_exited_tree.bind(node))
	
	_update_add_variable_button_visibility()


func _on_child_exited_tree(node: Node) -> void:
	if node is UmlClassNodeVariable:
		variable_removed.emit(node.description)
		node.tree_exited.disconnect(_on_child_exited_tree)
	
	_update_add_variable_button_visibility()


func _update_add_variable_button_visibility() -> void:
	_add_variable_button.visible = not get_children().any(func(child: Node):
		return child is UmlClassNodeVariable)
