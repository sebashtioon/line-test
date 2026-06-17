extends Node3D

@export var mainmenu_camera : Camera3D
@export var gamemanager : Node3D
@export var gamesequence: Node3D
@export var sequencestart: AnimationPlayer


func _ready() -> void:
	#mainmenu_camera.make_current()
	
	PlayerGlobal.world = $"."
