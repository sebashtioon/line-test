extends Node3D

@export var ringanimation: AnimationPlayer


func _ready() -> void:
	ringanimation.play(&"main")
