extends Node3D

@export var door: Node3D

func spawn_door() -> void:
	door.position.x = PlayerGlobal.player.door_spawn.global_position.x
	door.position.z = PlayerGlobal.player.door_spawn.global_position.z
