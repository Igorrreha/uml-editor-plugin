class_name UmlConnection

enum Type {
	ASSOCIATION,
	DIRECTED_ASSOCIATION,
	COMPOSITION,
	AGGREGATION,
	INHERITANCE,
	REALIZATION,
	DEPENDENCY,
}

enum HeadType {
	NONE,
	OPENED_ARROW,
	ARROW,
	FILLED_ARROW,
	DIAMOND,
	FILLED_DIAMOND,
}

enum LineType {
	STRAIGHT,
	DASHED,
}

var node_a: UmlNode
var node_b: UmlNode
var type: UmlConnection.Type

func _init(node_a: UmlNode, node_b: UmlNode, connection_type: UmlConnection.Type):
	self.node_a = node_a
	self.node_b = node_b
	self.type = connection_type
