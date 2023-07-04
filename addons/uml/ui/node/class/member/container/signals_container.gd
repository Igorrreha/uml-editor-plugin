class_name UmlClassNodeSignalsContainer
extends UmlClassNodeMembersContainer


func setup(content: UmlClassState) -> void:
	content.setup_bindings(self, "_state", [
		ReactiveResource.Binding
			.new("signals", _on_state_signals_changed, _on_membership_updated)
	])


func _on_state_signals_changed() -> void:
	var children_states = (get_children()
		.filter(func(child):
			return child is UmlClassNodeSignal)
		.map(func(child: UmlClassNodeSignal):
			return child.state))
	
	for member in _state.signals:
		if children_states.has(member):
			continue
		
		add_member()


func _on_membership_updated() -> void:
	_state.set_value("signals", _state.signals, _on_membership_updated)
