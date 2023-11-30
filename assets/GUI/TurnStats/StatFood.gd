extends Label

func _process(delta):
	# Food consumption in kWh per year. Takes in data from all modules regardless when placed.
	if (Global.foodConsumption) >= 10000:
		self.text = str("Your neighbourhood food consumption for the year " + str(Global.turn_count + 2023) + " is " +
		str(Global.foodConsumption) + " kg. Try harder to achieve net-zero food consumption!" )
	elif (Global.foodConsumption) <= 10000 and (Global.foodConsumption) > 0:
		self.text = str("Your food consumption for the year " + str(Global.turn_count + 2023) + " is " +
		str(Global.foodConsumption) + " kg. Good job! You're getting close to net-zero food consumption!" )	
	elif (Global.foodConsumption) == 0:
		self.text = str("Your food consumption for the year " + str(Global.turn_count + 2023) + " is " +
		str(Global.foodConsumption) + " kg. You have achieved net-zero food consumption!" )	
	else:
		self.text = str("Your food consumption for the year " + str(Global.turn_count + 2023) + " is " +
		str(Global.foodConsumption) + " kg. Congratulations! Your neighbourhood is producing more food than it consumes!" )	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
