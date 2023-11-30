extends Button

onready var tool_tip = preload("res://assets/GUI/Templates/ToolTip.tscn")
onready var bridge_selector = preload("res://assets/GUI/Templates/DirectionSelect.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Button_mouse_entered():
	var tool_tip_instance = tool_tip.instance()
	tool_tip_instance.slot = get_parent().get_index()
	
	tool_tip_instance.rect_position = get_parent().get_global_transform_with_canvas().origin - Vector2(500,0)
	
	add_child(tool_tip_instance)
	yield(get_tree().create_timer(0.35),"timeout")
	if has_node("ToolTip"):
		get_node("ToolTip").show()


func _on_Button_mouse_exited():
	get_node("ToolTip").free()


func _on_Button_pressed():
	var module_index = str(get_parent().get_index())
	Global.selected_module_index = module_index
	var module_name = str(GameData.item_data[module_index]["Name"])
	Global.selected_module_name = module_name
	if Global.selected_module_name == "Bridge":
		Global.bridgeDirection = 1
		 
		var bridge_direction = bridge_selector.instance()
#
		bridge_direction.rect_position = get_parent().get_global_transform_with_canvas().origin + Vector2(-180, 120)
		
		add_child(bridge_direction)
		if has_node("DirectionSelect"):
			get_node("DirectionSelect").show()
			yield(get_tree().create_timer(5), "timeout")
			if has_node("DirectionSelect"):
				get_node("DirectionSelect").free()



# Might not be needed anymore
#func _on_Button_toggled(button_pressed):
#	if button_pressed == true:
#		var module_index = str(get_parent().get_index())
#		Global.selected_module_index = module_index
#		var module_name = str(GameData.item_data[module_index]["Name"])
#		Global.selected_module_name = module_name
#	else:
#		Global.selected_module_index = null
#		Global.selected_module_name = null
#	print(Global.selected_module_index)
#	print(Global.selected_module_name)
