class_name UmlClassNodeMembersContainer
extends VBoxContainer


signal signal_added(description: UmlClassNode.SignalDescription)
signal variable_added(description: UmlClassNode.VariableDescription)
signal method_added(description: UmlClassNode.MethodDescription)

signal signal_removed(description: UmlClassNode.SignalDescription)
signal variable_removed(description: UmlClassNode.VariableDescription)
signal method_removed(description: UmlClassNode.MethodDescription)


@export var _tscn_signal: PackedScene
@export var _tscn_variable: PackedScene
@export var _tscn_method: PackedScene

@export var _signals_container: Node
@export var _variables_container: Node
@export var _methods_container: Node

@export var _add_signal_button: Button
@export var _add_variable_button: Button
@export var _add_method_button: Button


func add_signal() -> void:
	var new_signal = _tscn_signal.instantiate()
	_signals_container.add_child(new_signal)
	_on_member_added(new_signal)


func add_variable() -> void:
	var new_variable = _tscn_variable.instantiate()
	_variables_container.add_child(new_variable)
	_on_member_added(new_variable)


func add_method() -> void:
	var new_method = _tscn_method.instantiate()
	_methods_container.add_child(new_method)
	_on_member_added(new_method)


func _ready() -> void:
	for node in _signals_container.get_children():
		_on_member_added(node)
	
	for node in _variables_container.get_children():
		_on_member_added(node)
	
	for node in _methods_container.get_children():
		_on_member_added(node)
	
	_update_add_signal_button_visibility()
	_update_add_variable_button_visibility()
	_update_add_method_button_visibility()


func _on_member_added(node: Node) -> void:
	if node is UmlClassNodeVariable:
		variable_added.emit(node.description)
		node.tree_exited.connect(_on_child_exited_tree.bind(node))
		_update_add_variable_button_visibility()
	
	if node is UmlClassNodeSignal:
		signal_added.emit(node.description)
		node.tree_exited.connect(_on_child_exited_tree.bind(node))
		_update_add_signal_button_visibility()
	
	if node is UmlClassNodeMethod:
		method_added.emit(node.description)
		node.tree_exited.connect(_on_child_exited_tree.bind(node))
		_update_add_method_button_visibility()


func _on_child_exited_tree(node: Node) -> void:
	if node is UmlClassNodeSignal:
		signal_removed.emit(node.description)
		node.tree_exited.disconnect(_on_child_exited_tree)
		_update_add_signal_button_visibility()
	
	if node is UmlClassNodeVariable:
		variable_removed.emit(node.description)
		node.tree_exited.disconnect(_on_child_exited_tree)
		_update_add_variable_button_visibility()
	
	if node is UmlClassNodeMethod:
		method_removed.emit(node.description)
		node.tree_exited.disconnect(_on_child_exited_tree)
		_update_add_method_button_visibility()


func _update_add_signal_button_visibility() -> void:
	_add_signal_button.visible = not _signals_container.get_children().any(func(child: Node):
		return child is UmlClassNodeSignal)


func _update_add_variable_button_visibility() -> void:
	_add_variable_button.visible = not _variables_container.get_children().any(func(child: Node):
		return child is UmlClassNodeVariable)


func _update_add_method_button_visibility() -> void:
	_add_method_button.visible = not _methods_container.get_children().any(func(child: Node):
		return child is UmlClassNodeMethod)
