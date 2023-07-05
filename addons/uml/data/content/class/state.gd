class_name UmlClassState
extends UmlNodeContent


@export var self_class_name: String
@export var parent_class_name: String

@export var signals: Array[UmlClassSignalState]
@export var variables: Array[UmlClassVariableState]
@export var methods: Array[UmlClassMethodState]


func _init(self_class_name: String = "NewClass", parent_class_name: String = "Object", 
		signals: Array[UmlClassSignalState] = [],
		variables: Array[UmlClassVariableState] = [],
		methods: Array[UmlClassMethodState] = []) -> void:
	self.self_class_name = self_class_name
	self.parent_class_name = parent_class_name
	
	self.signals = signals
	self.variables = variables
	self.methods = methods
