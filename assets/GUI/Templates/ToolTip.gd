extends Popup

var slot = ""

func _ready():
	var module_id
	module_id = str(slot)
	get_node("N/M/V/ModuleName").set_text(GameData.item_data[module_id]["ShownName"])
	var item_stat = 1
	for i in range(GameData.item_stats.size()):
		var stat_name = GameData.item_stats[i]
		var stat_label = GameData.item_stat_labels[i]
		if GameData.item_data[module_id][stat_name] != null:
			var stat_value = GameData.item_data[module_id][stat_name]
			get_node("N/M/V/Stat" + str(item_stat) + "/Stat").set_text(stat_label + ": " + str(stat_value))
			item_stat += 1




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
