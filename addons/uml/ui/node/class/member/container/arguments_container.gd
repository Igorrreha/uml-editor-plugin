class_name UmlClassNodeArgumentsContainer
extends ReactiveCollectionContainer


@export var _chlid_divider_tscn: PackedScene#UmlClassNodeArgument


func add_new_argument() -> void:
	var new_argument_state = UmlClassArgumentState.new()
	_append_state_item(new_argument_state)


func _after_state_updated() -> void:
	super._after_state_updated()
	_update_child_dividers()


func _update_child_dividers() -> void:
	var prev_child: Node
	var cur_idx = 0
	while cur_idx < get_child_count():
		var child = get_child(cur_idx)
		
		if child is UmlClassNodeArgument:
			if prev_child is UmlClassNodeArgument:
				_create_divider(cur_idx)
				cur_idx += 2
			
			else:
				cur_idx += 1
			
			prev_child = child
			continue
		
		if (not prev_child is UmlClassNodeArgument
		or not prev_child
		or cur_idx == get_child_count() - 1):
			child.queue_free()
			cur_idx += 1
			continue
		
		cur_idx += 1
		prev_child = child
		continue


func _create_divider(idx: int) -> void:
	var new_divider = _chlid_divider_tscn.instantiate()
	add_child(new_divider)
	move_child(new_divider, idx)
