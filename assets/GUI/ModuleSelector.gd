extends Control

var template_module = preload("res://assets/GUI/Templates/Module.tscn")

onready var gridcontainer = get_node("M/ModulesContainer/MarginContainer/V/ScrollContainer/GridContainer")

func _ready():
	for i in GameData.item_data.keys():
		var module_slot_new = template_module.instance()
		var item_name = GameData.item_data[i]["Name"]
		var icon_texture = load("res://assets/GUI/ModuleIcons/" + item_name + ".png")
		module_slot_new.get_node("Button").set_button_icon(icon_texture)
		gridcontainer.add_child(module_slot_new, true)

func _on_ModulesUI_mouse_entered():
	print("UI Entered")
	$"../Scene".set_process(false)

func _on_ModulesUI_mouse_exited():
	print("UI Exited")
	$"../Scene".set_process(true)
