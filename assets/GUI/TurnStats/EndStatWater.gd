extends Label

func _process(delta):
	# Water consumption in l per year. Takes in data from all modules regardless when placed.
	if Global.waterConsumption >= 100000:
		self.text = str("Your neighbourhood consumed " + str(Global.waterConsumption) + " cubic meters of water overall! Try harder next time to achieve net-zero water consumption!" )
	elif Global.waterConsumption <= 100000 and Global.waterConsumption > 0:
		self.text = str("Your neighbourhood consumed " + str(Global.waterConsumption) + " cubic meters of water overall! You got close to net-zero water consumption!" )
	elif Global.waterConsumption == 0:
		self.text = str("Your neighbourhood consumed " + str(Global.waterConsumption) + " cubic meters of water overall! You have achieved net-zero water consumption!" )
	elif Global.waterConsumption < 0:
		self.text = str("Your neighbourhood consumed " + str(Global.waterConsumption) + " cubic meters of water overall! Your neighbourhood is producing more water than it consumes!" )
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
