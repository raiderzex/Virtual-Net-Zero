extends Popup

var chartsUI = preload("res://assets/GUI/TurnStats/ChartsUI.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.show()
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CloseButton_button_up():
	Global.turn_count += 1
	# Stats for making charts
	# Add carbon for year to carbon list

	queue_free()


func _on_StatsButton_button_up():
	add_child(chartsUI.instance())
	if has_node("ChartsUI"):
		get_node("ChartsUI").show()
