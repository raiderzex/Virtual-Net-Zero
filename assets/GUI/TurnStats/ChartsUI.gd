extends Popup

var carbonChart = preload("res://assets/GUI/TurnStats/StatCharts/CarbonChart.tscn")
var waterChart = preload("res://assets/GUI/TurnStats/StatCharts/WaterChart.tscn")
var foodChart = preload("res://assets/GUI/TurnStats/StatCharts/FoodChart.tscn")
var energyChart = preload("res://assets/GUI/TurnStats/StatCharts/EnergyChart.tscn")
var vibrancyChart = preload("res://assets/GUI/TurnStats/StatCharts/VibrancyChart.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CloseButton_pressed():
	queue_free()


func _on_CarbonButton_button_up():
	add_child(carbonChart.instance())
	if has_node("CarbonPopup"):
		get_node("CarbonPopup").show()


func _on_WaterButton_button_up():
	add_child(waterChart.instance())
	if has_node("WaterPopup"):
		get_node("WaterPopup").show()


func _on_FoodButton_button_up():
	add_child(foodChart.instance())
	if has_node("FoodPopup"):
		get_node("FoodPopup").show()


func _on_EnergyButton_button_up():
	add_child(energyChart.instance())
	if has_node("EnergyPopup"):
		get_node("EnergyPopup").show()


func _on_VibrancyButton_button_up():
	add_child(vibrancyChart.instance())
	if has_node("VibrancyPopup"):
		get_node("VibrancyPopup").show()
