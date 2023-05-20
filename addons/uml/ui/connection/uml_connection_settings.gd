@tool

class_name UmlConnectionSettings
extends Resource


@export var type: UmlConnection.Type:
	set(v):
		resource_name = UmlConnection.Type.find_key(v)
		type = v
@export var head_type: UmlConnection.HeadType
@export var tail_type: UmlConnection.HeadType
@export var line_type: UmlConnection.LineType
