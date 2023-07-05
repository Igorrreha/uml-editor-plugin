class_name UmlClassNodeSignalsContainer
extends UmlClassNodeMembersContainer


func setup(content: UmlClassState) -> void:
	content.setup_bindings(self, "_state", [
		ReactiveResource.Binding
			.new("signals", _on_state_signals_updated, _update_state_signals)
	])


func add_empty_signal() -> void:
	var new_member = UmlClassSignalState.new()
	_add_member(new_member)
	_update_state_signals()


func remove_node(node: UmlClassNodeSignal) -> void:
	_state.signals.erase(node.state)
	_remove_member(node)
	_update_state_signals()


func _on_member_asked_to_be_removed(node: UmlClassNodeMember) -> void:
	remove_node(node)


func _on_state_signals_updated() -> void:
	var members_to_remove = _get_children_states().filter(func(state: UmlClassSignalState):
		return not _state.signals.has(state))
	_remove_members(members_to_remove)
	
	var children_states = _get_children_states()
	var members_to_add = _state.signals.filter(func(state: UmlClassSignalState):
		return not children_states.has(state))
	_add_members(members_to_add)


func _get_children_states() -> Array[UmlClassSignalState]:
	var states: Array[UmlClassSignalState]
	states.assign((get_children()
		.filter(func(child):
			return child is UmlClassNodeSignal)
		.map(func(child: UmlClassNodeSignal):
			return child.state)))
	return states


func _update_state_signals() -> void:
	_state.set_value("signals", _state.signals, _update_state_signals)
