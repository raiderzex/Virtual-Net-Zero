extends Label

func _process(delta):
	# Carbon goal tier of >250k kgCO2eq per year. Operational carbon will add on, embodied only on year of placement.
	if (Global.embodiedCarbon + Global.operationalCarbon) >= 250000:
		self.text = str("Your final carbon cost is " +
		str(Global.embodiedCarbon + Global.operationalCarbon) + " kgCO2eq. Try harder next time to achieve carbon net-zero!" )
	elif (Global.embodiedCarbon + Global.operationalCarbon) <= 250000 and (Global.embodiedCarbon + Global.operationalCarbon) > 0:
		self.text = str("Your final carbon cost is " +
		str(Global.embodiedCarbon + Global.operationalCarbon) + " kgCO2eq. Good job! You're got close to carbon net-zero!" )
	elif (Global.embodiedCarbon + Global.operationalCarbon) == 0:
		self.text = str("Your final carbon cost is " +
		str(Global.embodiedCarbon + Global.operationalCarbon) + " kgCO2eq. You have achieved carbon net-zero!" )
	else:
		self.text = str("Your final carbon cost is " +
		str(Global.embodiedCarbon + Global.operationalCarbon) + " kgCO2eq. Congratulations! Your neighbourhood is carbon negative!" )	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
