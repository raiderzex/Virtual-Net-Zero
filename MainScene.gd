extends Node

var rules_module = preload("res://RulesUI.tscn")
var rules_page = preload("res://RulesUI2.tscn")

var tree = get_tree()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Hide rules page behind first page so reverse show order
	var rules_show = rules_page.instance()
	add_child(rules_show)
	if has_node("RulesUI2"):
		get_node("RulesUI2").show()
	
	# This is the first introduction page to be shown
	var rules_instance = rules_module.instance()
#	confirm_instance.popup_centered()
	add_child(rules_instance)
	if has_node("RulesUI"):
		get_node("RulesUI").show()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.takeScreenshot == true:
		print("yes")
		var image = $ViewportContainer/Camera.get_viewport().get_texture().get_data()
		image.flip_y()
		image.save_png("user://images/screenshot.png")
		image.save_png("C://VirtualNetZero/screenshot.png")
		Global.imageSS = image
		Global.takeScreenshot = false
