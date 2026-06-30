@tool
extends Node3D

@export var env: Environment

@export_tool_button("toggle hallway", "Node3D") var hallway_toggled_tool_button = _on_hallway_toggled_tool_button_pressed

var hallway_toggled : bool = false

func _on_hallway_toggled_tool_button_pressed() -> void:
	hallway_toggled = !hallway_toggled
	print(str(hallway_toggled))
	
	$"../../door/hallway".visible = hallway_toggled
	$"../../door/passageway".visible = !hallway_toggled
	$"../../floor1".visible = !hallway_toggled
	$"../../door/SpotLight3D".visible = !hallway_toggled
	$"../../door/ceiling_light".visible = !hallway_toggled
	
	env.glow_enabled = hallway_toggled
	env.volumetric_fog_enabled = !hallway_toggled
