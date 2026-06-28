extends Node3D

enum DOOR_STATES {CLOSED, OPEN}

var DOOR_STATE : DOOR_STATES = DOOR_STATES.CLOSED

@export var DoorAnimation : AnimationPlayer
@export var HingePivot : Node3D
@export var STARTING_DOOR_STATE : DOOR_STATES
@export var debounce: Timer
@export var mesh: MeshInstance3D

@export var key: Label

@export var doorclosevoiceline: Timer
var doorclosevoiceline_said : bool = false
@export var sequence_3: AnimationPlayer

var can_use_door : bool = true
var can_interact_with_door : bool = true

var played_door_close_voiceline : bool = false

var player_in_portal_room : bool = false:
	set(value):
		player_in_portal_room = value
		
		if value:
			doorclosevoiceline.start()
		else:
			doorclosevoiceline.stop()

func _ready() -> void:
	DOOR_STATE = STARTING_DOOR_STATE
	if DOOR_STATE == DOOR_STATES.CLOSED:
		HingePivot.rotation_degrees.y = 90
	else:
		HingePivot.rotation_degrees.y = 0

func _door_triggered() -> void:
	if can_use_door and can_interact_with_door:
		if DOOR_STATE == DOOR_STATES.CLOSED:
			DOOR_STATE = DOOR_STATES.OPEN
			DoorAnimation.play(&"open")
		else:
			DOOR_STATE = DOOR_STATES.CLOSED
			DoorAnimation.play(&"close")
			
			if PlayerGlobal.world.player_in_portal_room:
				key.visible = false
				can_interact_with_door = false
			
		start_debounce()

func start_debounce() -> void:
	can_use_door = false
	debounce.start()

func _on_debounce_timeout() -> void:
	can_use_door = true


func _on_doorclosevoiceline_timeout() -> void:
	if DOOR_STATE != DOOR_STATES.CLOSED and player_in_portal_room and !doorclosevoiceline_said:
		sequence_3.play(&"sequence_3/main")
		doorclosevoiceline_said = true
