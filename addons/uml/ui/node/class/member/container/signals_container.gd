class_name UmlClassNodeSignalsContainer
extends UmlClassNodeMembersContainer


func add_empty_signal() -> void:
	var new_member = UmlClassSignalState.new()
	_append_state_item(new_member)
