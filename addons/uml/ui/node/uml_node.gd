class_name UmlNode
extends GraphNode


const HEADER_HEIGHT: = 31

var _node_state: UmlNodeState


func setup(state: UmlNodeState) -> void:
	state.setup_bindings(self, "_node_state", [
		ReactiveResource.Binding
			.new("position", _on_state_position_changed, _on_position_offset_changed)
	])


func _exit_tree() -> void:
	_node_state.remove_callback("position", _on_state_position_changed)


func _ready() -> void:
	position_offset_changed.connect(_on_position_offset_changed)


func _on_state_position_changed() -> void:
	position_offset = _node_state.position


func _on_position_offset_changed() -> void:
	_node_state.set_value("position", position_offset, _on_position_offset_changed)
