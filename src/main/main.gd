extends Node3D

@export var mainmenu_camera : Camera3D
@export var gamemanager : Node3D
@export var gamesequence: Node3D

@export var hallway: MeshInstance3D
@export var door_mesh: MeshInstance3D



func _ready() -> void:
	#mainmenu_camera.make_current()
	PlayerGlobal.world = $"."


func _on_portalswitchnotifier_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"player_body"):
		var mat_hallway = hallway.mesh.surface_get_material(0)
		mat_hallway.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_DISABLED
		
		
		var door_mat_1 = door_mesh.mesh.surface_get_material(0)
		door_mat_1.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_DISABLED

		var door_mat_2 = door_mesh.mesh.surface_get_material(1)
		door_mat_2.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_DISABLED

		var door_mat_3 = door_mesh.mesh.surface_get_material(2)
		door_mat_3.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_DISABLED


func _on_portalswitchnotifier_body_exited(body: Node3D) -> void:
	if body.is_in_group(&"player_body"):
		var mat_hallway = hallway.mesh.surface_get_material(0)
		mat_hallway.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_CUSTOM
		mat_hallway.stencil_flags = 1
		mat_hallway.stencil_compare = BaseMaterial3D.StencilCompare.STENCIL_COMPARE_EQUAL
		mat_hallway.stencil_reference = 1
		

		var door_mat_1 = door_mesh.mesh.surface_get_material(0)
		door_mat_1.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_CUSTOM
		door_mat_1.stencil_flags = 1
		door_mat_1.stencil_compare = BaseMaterial3D.StencilCompare.STENCIL_COMPARE_EQUAL
		door_mat_1.stencil_reference = 1

		var door_mat_2 = door_mesh.mesh.surface_get_material(1)
		door_mat_2.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_CUSTOM
		door_mat_2.stencil_flags = 1
		door_mat_2.stencil_compare = BaseMaterial3D.StencilCompare.STENCIL_COMPARE_EQUAL
		door_mat_2.stencil_reference = 1

		var door_mat_3 = door_mesh.mesh.surface_get_material(2)
		door_mat_3.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_CUSTOM
		door_mat_3.stencil_flags = 1
		door_mat_3.stencil_compare = BaseMaterial3D.StencilCompare.STENCIL_COMPARE_EQUAL
		door_mat_3.stencil_reference = 1
