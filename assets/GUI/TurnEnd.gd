extends TextureButton

onready var confirm = preload("res://assets/GUI/Templates/Confirmation.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TurnEnd_pressed():
	var confirm_instance = confirm.instance()
#	confirm_instance.popup_centered()
	add_child(confirm_instance)
	if has_node("Confirmation"):
		get_node("Confirmation").show()
	print("Turn End Button Pressed")
