class_name UmlClassNodeVariablesContainer
extends UmlClassNodeMembersContainer


func add_empty_variable() -> void:
	var new_member = UmlClassVariableState.new()
	_append_state_item(new_member)
