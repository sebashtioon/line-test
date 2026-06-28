extends Node3D

@export var sequencestart: AnimationPlayer
@export var sequence_2: AnimationPlayer

@export var door: Node3D
@export var lightswitch: AudioStreamPlayer3D

# flags
var door_spawned__start : bool = false
var looked_at_door__start : bool = false

func reset_flags(to_start : bool = true) -> void:
	if to_start:
		door_spawned__start = false

func spawn_door() -> void:
	door.position.x = PlayerGlobal.player.door_spawn.global_position.x
	door.position.z = PlayerGlobal.player.door_spawn.global_position.z
	door.rotation_degrees.y = PlayerGlobal.player.door_spawn.global_rotation_degrees.y + 90
	door_spawned__start = true
	door.visible = true

func _on_door_look(area: Area3D) -> void:
	if area.is_in_group(&"raycast_mimic_adjustable") and door_spawned__start and !looked_at_door__start:
		sequence_2.play(&"sequence_2/main")
		looked_at_door__start = true

func goto_hallway() -> void:
	lightswitch.play()
	$"../door/hallway".visible = true
	$"../door/passageway".visible = false
	$"../floor1".visible = false
	$"../door/SpotLight3D".visible = false
	$"../door/ceiling_light".visible = false
	

func _on_mainroomtoswitch_timeout() -> void:
	goto_hallway()
