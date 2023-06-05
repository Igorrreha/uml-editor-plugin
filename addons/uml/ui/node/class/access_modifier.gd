extends OptionButton


signal modifier_selected(modifier: Uml.ClassMemberAccessModifier)


func _on_item_selected(index: int) -> void:
	var item_id = get_popup().get_item_id(index)
	if not Uml.ClassMemberAccessModifier.values().any(func(value: int):
		return value == item_id):
		printerr("Can't find access modifier by item ID %s" % item_id)
		
		selected = 0
		return
	
	modifier_selected.emit(item_id)
