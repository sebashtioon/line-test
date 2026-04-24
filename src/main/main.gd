extends Node3D

@export var mainmenu_camera: Camera3D


func _ready() -> void:
	mainmenu_camera.make_current()
