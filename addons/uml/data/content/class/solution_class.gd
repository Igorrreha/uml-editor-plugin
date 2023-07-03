class_name UmlSolutionNodeClass
extends UmlSolutionNodeContent


@export var self_class_name: String
@export var parent_class_name: String

@export var signals: Array[UmlSolutionClassSignal]
@export var variables: Array[UmlSolutionClassVariable]
@export var methods: Array[UmlSolutionClassMethod]


func _init(self_class_name: String, parent_class_name: String, 
		signals: Array[UmlSolutionClassSignal],
		variables: Array[UmlSolutionClassVariable],
		methods: Array[UmlSolutionClassMethod]) -> void:
	self.self_class_name = self_class_name
	self.parent_class_name = parent_class_name
	
	self.signals = signals
	self.variables = variables
	self.methods = methods
