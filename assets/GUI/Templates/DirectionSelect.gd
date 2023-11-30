extends Popup

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DirectionOption_item_selected(index):
	match index:
		0:
			Global.bridgeDirection = 1
			print("Front selected")
			select_item(0)
		1:
			Global.bridgeDirection = 2
			print("Back selected")
			select_item(1)
		2:
			Global.bridgeDirection = 3
			print("Left selected")
			select_item(2)
		3:
			Global.bridgeDirection = 4
			print("Right selected")
			select_item(4)
			
func select_item(id):
	get_node("N/M/V/DirectionOption").select(id)

