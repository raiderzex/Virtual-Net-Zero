extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_item("Front")
	self.add_item("Back")
	self.add_item("Left")
	self.add_item("Right")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
