class_name UmlClassNodeMethodsContainer
extends UmlClassNodeMembersContainer


func add_empty_method() -> void:
	var new_member = UmlClassMethodState.new()
	_append_state_item(new_member)
