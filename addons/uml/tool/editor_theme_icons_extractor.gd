@tool
extends EditorScript


const EXTRACT_PATH: String = "res://addons/uml/ui/editor_theme_icons.tres"


func _run() -> void:
	_extract_editor_theme_icons()


func _extract_editor_theme_icons() -> void:
	var theme_type = "EditorIcons"
	var editor_theme = get_editor_interface().get_base_control().theme
	
	var theme = Theme.new()
	for icon_name in editor_theme.get_icon_list(theme_type):
		theme.set_icon(icon_name, theme_type, editor_theme.get_icon(icon_name, theme_type))
	
	ResourceSaver.save(theme, EXTRACT_PATH)
