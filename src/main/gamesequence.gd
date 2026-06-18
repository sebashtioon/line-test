extends Node3D

@export var door: Node3D

func spawn_door() -> void:
	door.position.x = PlayerGlobal.player.door_spawn.global_position.x
	door.position.z = PlayerGlobal.player.door_spawn.global_position.z
	door.rotation_degrees.y = PlayerGlobal.player.door_spawn.global_rotation_degrees.y - 90
