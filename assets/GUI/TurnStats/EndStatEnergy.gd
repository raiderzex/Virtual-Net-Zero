extends Label

func _process(delta):
	# Energy consumption in kWh per year. Takes in data from all modules regardless when placed.
	if (Global.energyConsumption) >= 250000:
		self.text = str("Your final energy consumption is " +
		str(Global.energyConsumption) + " kWh. Try harder next time to achieve net-zero energy!" )
	elif (Global.energyConsumption) <= 250000 and (Global.energyConsumption) > 0:
		self.text = str("Your final energy consumption is " +
		str(Global.energyConsumption) + " kWh. Good job! You're got close to net-zero energy!" )	
	elif (Global.energyConsumption) == 0:
		self.text = str("Your final energy consumption is " +
		str(Global.energyConsumption) + " kWh. You have achieved net-zero energy!" )	
	else:
		self.text = str("Your final energy consumption is " +
		str(Global.energyConsumption) + " kWh. Congratulations! Your neighbourhood is producing more energy than it consumes!" )	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
