class_name UmlClassNodeArgumentsContainer
extends HBoxContainer


@export var _tscn_argument: PackedScene
@export var _tscn_chlid_divider: PackedScene


signal argument_added(description: UmlArgumentDescription)
signal argument_removed(description: )


func add_argument() -> void:
	var new_argument: = _tscn_argument.instantiate() as UmlClassNodeArgument
	add_child(new_argument)
	
	_on_member_added(new_argument)


func _ready() -> void:
	for child in get_children():
		_on_member_added(child)
	
	_update_child_dividers()


func _on_member_added(node: UmlClassNodeArgument) -> void:
	argument_added.emit(node.description)
	node.tree_exited.connect(_on_child_exited_tree.bind(node))
	
	_update_child_dividers()


func _on_child_exited_tree(node: UmlClassNodeArgument) -> void:
	argument_removed.emit(node.description)
	node.tree_exited.disconnect(_on_child_exited_tree)
	
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
	var new_divider = _tscn_chlid_divider.instantiate()
	add_child(new_divider)
	move_child(new_divider, idx)
