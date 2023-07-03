class_name UmlNodeState
extends ReactiveResource


@export var position: Vector2
@export var content: UmlNodeContent


func _init(position: Vector2, content: UmlNodeContent) -> void:
	self.position = position
	self.content = content
