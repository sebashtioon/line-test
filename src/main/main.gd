extends Node3D

@export var mainmenu_camera : Camera3D
@export var gamemanager : Node3D
@export var gamesequence: Node3D

@export var hallway: MeshInstance3D



func _ready() -> void:
	#mainmenu_camera.make_current()
	PlayerGlobal.world = $"."


func _on_portalswitchnotifier_body_entered(body: Node3D) -> void:
	var mat = hallway.mesh.surface_get_material(0)
	mat.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_DISABLED


func _on_portalswitchnotifier_body_exited(body: Node3D) -> void:
	var mat = hallway.mesh.surface_get_material(0)
	mat.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_CUSTOM
	mat.stencil_flags = 1
	mat.stencil_compare = BaseMaterial3D.StencilCompare.STENCIL_COMPARE_EQUAL
	mat.stencil_reference = 1
