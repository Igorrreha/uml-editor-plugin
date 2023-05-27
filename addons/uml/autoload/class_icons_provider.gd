extends Node


const EDITOR_THEME: Theme = preload("res://addons/uml/ui/editor_theme_icons.tres")
const THEME_TYPE: String = "EditorIcons"

var _global_classes_icons: Dictionary = {}


func update_icons_dictionary() -> void:
	var class_bases: Dictionary
	
	for class_description in ProjectSettings.get_global_class_list():
		var icon_path = class_description["icon"]
		_global_classes_icons[class_description["class"]] = (null if icon_path.is_empty()
				else load(icon_path))
		class_bases[class_description["class"]] = class_description["base"]
	
	# fill empty icons with base class icons
	for cur_class in _global_classes_icons:
		var cur_icon: Texture2D =_global_classes_icons[cur_class]
		var inheritance_chain = [cur_class]
		
		var search_class = cur_class
		var search_icon = cur_icon
		while not search_icon:
			search_icon = (_global_classes_icons[search_class]
					if _global_classes_icons.has(search_class) 
					else null)
			
			if not search_icon:
				if class_bases.has(search_class):
					search_class = class_bases[search_class]
					inheritance_chain.append(search_class)
					continue
				
				search_icon = _get_default_editor_icon(search_class)
			
			for item in inheritance_chain:
				_global_classes_icons[item] = search_icon
			
			break


func get_object_icon(object: Object) -> Texture2D:
	return get_icon(object.get_class())


func get_icon(obj_class_name: String) -> Texture2D:
	update_icons_dictionary()
	if _global_classes_icons.has(obj_class_name):
		return _global_classes_icons.get(obj_class_name)
		
	return _get_default_editor_icon(obj_class_name)


func _get_default_editor_icon(obj_class_name: String) -> Texture2D:
	var icon = null
	while not icon and not obj_class_name.is_empty():
		if EDITOR_THEME.has_icon(obj_class_name, THEME_TYPE):
			return EDITOR_THEME.get_icon(obj_class_name, THEME_TYPE)
		
		obj_class_name = (ClassDB.get_parent_class(obj_class_name)
				if ClassDB.class_exists(obj_class_name)
				else "")
	
	return icon
