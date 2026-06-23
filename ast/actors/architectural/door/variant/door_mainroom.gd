extends Node3D

enum DOOR_STATES {CLOSED, OPEN}

var DOOR_STATE : DOOR_STATES = DOOR_STATES.CLOSED

@export var DoorAnimation : AnimationPlayer
@export var HingePivot : Node3D
@export var STARTING_DOOR_STATE : DOOR_STATES
@export var debounce: Timer

@export var mesh: MeshInstance3D

var can_use_door : bool = true

func _ready() -> void:
	DOOR_STATE = STARTING_DOOR_STATE
	if DOOR_STATE == DOOR_STATES.CLOSED:
		HingePivot.rotation_degrees.y = 90
	else:
		HingePivot.rotation_degrees.y = 0

func _door_triggered() -> void:
	if can_use_door:
		if DOOR_STATE == DOOR_STATES.CLOSED:
			DOOR_STATE = DOOR_STATES.OPEN
			DoorAnimation.play(&"open")
		else:
			DOOR_STATE = DOOR_STATES.CLOSED
			DoorAnimation.play(&"close")
			
		start_debounce()

func start_debounce() -> void:
	can_use_door = false
	debounce.start()

func _on_debounce_timeout() -> void:
	can_use_door = true
