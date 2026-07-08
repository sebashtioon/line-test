extends Node3D

@export var ringanimation: AnimationPlayer
@export var phone: MeshInstance3D
@export var phonepickup: AudioStreamPlayer3D

var phone_pickedup : bool = false

func _ready() -> void:
	ringanimation.play(&"main")

func _on_phone_pickup() -> void:
	if !phone_pickedup:
		phone_pickedup = true
		phone.visible = false # set model phone mesh to invis
		PlayerGlobal.player.phone.visible = true # phone on player head visible
		
		phonepickup.play()
		ringanimation.stop()
		$interactablecomponent/Contents/UI.visible = false
		
		await get_tree().create_timer(1.0).timeout
		#PlayerGlobal.world.gamesequence.sequencestart.play(&"sequencestart/main")
		PlayerGlobal.world.gamesequence.spawn_door() # TEST
