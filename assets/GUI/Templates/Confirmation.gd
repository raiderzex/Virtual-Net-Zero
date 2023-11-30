extends Popup

var turnstats = preload("res://assets/GUI/TurnStats/TurnStats.tscn")
var endstats = preload("res://assets/GUI/TurnStats/EndStats.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Confirmation Loaded") # Replace with function body.


func _on_YesButton_pressed():
	if Global.turn_count < 30:
		Global.selected_module_name = null
		yield(get_tree().create_timer(0.25), "timeout")
		var turn = turnstats.instance()
		add_child(turn)
		Global.carbonScoreList.append(int(Global.embodiedCarbon + Global.operationalCarbon))
		Global.waterScoreList.append(int(Global.waterConsumption))
		Global.foodScoreList.append(int(Global.foodConsumption))
		Global.energyScoreList.append(int(Global.energyConsumption))
		Global.vibrancyScoreList.append(int(Global.vibrancy))
		Global.turnList.append(int(Global.turn_count))
		if has_node("TurnStats"):
			get_node("TurnStats").show()
		self.hide()
	elif Global.turn_count == 30:
		Global.takeScreenshot = true
		yield(get_tree().create_timer(0.25), "timeout")
		var endTurn = endstats.instance()
		add_child(endTurn)
		Global.carbonScoreList.append(int(Global.embodiedCarbon + Global.operationalCarbon))
		Global.waterScoreList.append(int(Global.waterConsumption))
		Global.foodScoreList.append(int(Global.foodConsumption))
		Global.energyScoreList.append(int(Global.energyConsumption))
		Global.vibrancyScoreList.append(int(Global.vibrancy))
		Global.turnList.append(int(Global.turn_count))
		if has_node("EndStats"):
			get_node("EndStats").show()
		self.hide()
	else:
		queue_free()

func _on_NoButton_pressed():
	queue_free()
