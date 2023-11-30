extends MenuButton

onready var tool_tip = preload("res://assets/GUI/Templates/ToolTip.tscn")

var module_popup

var texture0= load("res://assets/GUI/ModuleIcons/Grass.png")
var texture1= load("res://assets/GUI/ModuleIcons/Pavement.png")
var texture2= load("res://assets/GUI/ModuleIcons/GroundFloor.png")
var texture3= load("res://assets/GUI/ModuleIcons/Residential.png")
var texture4= load("res://assets/GUI/ModuleIcons/Office.png")
var texture5= load("res://assets/GUI/ModuleIcons/SolarPanels.png")
var texture6= load("res://assets/GUI/ModuleIcons/Greenhouse.png")
var texture7= load("res://assets/GUI/ModuleIcons/Trees.png")


func _ready():
	module_popup = get_popup()
	module_popup.add_icon_item(texture0, "Grass")
	module_popup.add_icon_item(texture1, "Pavement")
	module_popup.add_icon_item(texture2, "Ground Floor")
	module_popup.add_icon_item(texture3, "Residential")
	module_popup.add_icon_item(texture4, "Office")
	module_popup.add_icon_item(texture5, "Solar Panels")
	module_popup.add_icon_item(texture6, "Greenhouse")
	module_popup.add_icon_item(texture7, "Trees")
	module_popup.connect("id_focused", self, "_on_module_hovered")
	
func _on_module_hovered(id):
	print(id)
