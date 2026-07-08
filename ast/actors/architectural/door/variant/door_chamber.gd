extends Node3D

enum DOOR_STATES {CLOSED, OPEN}

var DOOR_STATE : DOOR_STATES = DOOR_STATES.CLOSED

@export var DoorAnimation : AnimationPlayer
@export var HingePivot : Node3D
@export var STARTING_DOOR_STATE : DOOR_STATES
@export var debounce: Timer
@export var mesh: MeshInstance3D

@export var key: Label
@export var ui: Sprite3D

var can_use_door : bool = true
var can_interact_with_door : bool = true


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
			
		start_debounce()

func start_debounce() -> void:
	can_use_door = false
	debounce.start()

func _on_debounce_timeout() -> void:
	can_use_door = true


func _on_door_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"close" and PlayerGlobal.world.gamesequence.in_chamberdoor_hallway:
		can_interact_with_door = false
		ui.visible = false
		
		await get_tree().create_timer(3.9).timeout
		
		$"../../gamemanager/fadelayer/fade".modulate = Color(1, 1, 1, 0)
		$"../../gamemanager/fadelayer/fade".visible = true
		
		var tween = get_tree().create_tween()
		tween.connect("finished", goto_end)
		tween.tween_property($"../../gamemanager/fadelayer/fade", "modulate:a", 1, 3)

func goto_end() -> void:
	pass
