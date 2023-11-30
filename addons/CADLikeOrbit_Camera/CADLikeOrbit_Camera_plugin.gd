tool
extends EditorPlugin

func _enter_tree():
	add_custom_type(
		"CADLikeOrbit_Camera", "Camera",
		load("res://addons/CADLikeOrbit_Camera/CADLikeOrbit_Camera.gd"),
		load("res://addons/CADLikeOrbit_Camera/camera_icon.svg")
	)

func _exit_tree():
	remove_custom_type("CADLikeOrbit_Camera")