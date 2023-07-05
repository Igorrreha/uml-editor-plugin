class_name UmlClassNodeMethodsContainer
extends UmlClassNodeMembersContainer


func setup(content: UmlClassState) -> void:
	content.setup_bindings(self, "_state", [
		ReactiveResource.Binding
			.new("methods", _on_state_methods_updated, _update_state_methods)
	])


func add_empty_method() -> void:
	var new_member = UmlClassMethodState.new()
	_add_member(new_member)
	_update_state_methods()


func remove_node(node: UmlClassNodeMethod) -> void:
	_state.methods.erase(node.state)
	_remove_member(node)
	_update_state_methods()


func _on_member_asked_to_be_removed(node: UmlClassNodeMember) -> void:
	remove_node(node)


func _on_state_methods_updated() -> void:
	var members_to_remove = _get_children_states().filter(func(state: UmlClassMethodState):
		return not _state.methods.has(state))
	_remove_members(members_to_remove)
	
	var children_states = _get_children_states()
	var members_to_add = _state.methods.filter(func(state: UmlClassMethodState):
		return not children_states.has(state))
	_add_members(members_to_add)


func _get_children_states() -> Array[UmlClassMethodState]:
	var states: Array[UmlClassMethodState]
	states.assign((get_children()
		.filter(func(child):
			return child is UmlClassNodeMethod)
		.map(func(child: UmlClassNodeMethod):
			return child.state)))
	return states


func _update_state_methods() -> void:
	_state.set_value("methods", _state.methods, _update_state_methods)
