extends Label

func _process(delta):
	# Food consumption in kWh per year. Takes in data from all modules regardless when placed.
	if (Global.vibrancy) <= 1:
		self.text = str("Your final neighbourhood vibrancy score in is " +
		str(Global.vibrancy) + ". Try harder next time to make a more vibrant neighbourhood!" )
	elif (Global.vibrancy) <= 2 and (Global.vibrancy) > 1:
		self.text = str("Your final neighbourhood vibrancy score in is " +
		str(Global.vibrancy) + ". Good job! Your neighbourhood is becoming more vibrant" )	
	else:
		self.text = str("Your final neighbourhood vibrancy score in is " +
		str(Global.vibrancy) + ". Congratulations! You have achieved a high level of vibrancy in your neighbourhood!" )	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
