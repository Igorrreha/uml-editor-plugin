class_name UmlClassNodeVariablesContainer
extends UmlClassNodeMembersContainer


func setup(content: UmlClassState) -> void:
	content.setup_bindings(self, "_state", [
		ReactiveResource.Binding
			.new("variables", _on_state_variables_updated, _update_state_variables)
	])


func add_empty_variable() -> void:
	var new_member = UmlClassVariableState.new()
	_add_member(new_member)
	_update_state_variables()


func remove_node(node: UmlClassNodeVariable) -> void:
	_state.variables.erase(node.state)
	_remove_member(node)
	_update_state_variables()


func _on_member_asked_to_be_removed(node: UmlClassNodeMember) -> void:
	remove_node(node)


func _on_state_variables_updated() -> void:
	var members_to_remove = _get_children_states().filter(func(state: UmlClassVariableState):
		return not _state.variables.has(state))
	_remove_members(members_to_remove)
	
	var children_states = _get_children_states()
	var members_to_add = _state.variables.filter(func(state: UmlClassVariableState):
		return not children_states.has(state))
	_add_members(members_to_add)


func _get_children_states() -> Array[UmlClassVariableState]:
	return (get_children()
		.filter(func(child):
			return child is UmlClassNodeVariable)
		.map(func(child: UmlClassNodeVariable):
			return child.state))


func _update_state_variables() -> void:
	_state.set_value("variables", _state.variables, _update_state_variables)
