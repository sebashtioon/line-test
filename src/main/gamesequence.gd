extends Node3D

@export var door: Node3D


# flags
var door_spawned__start : bool = false

func reset_flags(to_start : bool = true) -> void:
	if to_start:
		door_spawned__start = false

func spawn_door() -> void:
	door.position.x = PlayerGlobal.player.door_spawn.global_position.x
	door.position.z = PlayerGlobal.player.door_spawn.global_position.z
	door.rotation_degrees.y = PlayerGlobal.player.door_spawn.global_rotation_degrees.y - 90
	door_spawned__start = true

func _on_door_look(area: Area3D) -> void:
	if area.is_in_group(&"raycast_mimic") and door_spawned__start:
		print("nice")
