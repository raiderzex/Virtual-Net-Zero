extends Node

var item_data = {}
var item_stats = ["Cost", "ActivityScore", "PopulationScore", "EmbodiedCarbon", "OperationalCarbon", "EnergyProduced", "EnergyConsumed", "WaterConsumed", "WaterCaptured", "FoodProduced", "FoodConsumed"]
var item_stat_labels = ["Cost", "Activity Level Added", "Population Added", "Embodied Carbon (kgCO2eq)", "Operational Carbon (kgCO2eq)", "Energy Produced (kWh/year)", "Energy Consumed (kWh/year)", "Water Consumed (m3/year)", "Water Captured (m3/year)", "Food Produced (kg/year)", "Food Consumed (kg/year)"]

func _ready():
	var item_data_file = File.new()
	item_data_file.open("res://data/ModuleData.json", File.READ)
	var item_data_json = JSON.parse(item_data_file.get_as_text())
	item_data_file.close()
	item_data = item_data_json.result
