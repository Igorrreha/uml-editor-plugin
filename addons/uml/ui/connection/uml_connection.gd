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