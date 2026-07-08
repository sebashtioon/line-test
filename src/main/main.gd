extends Node3D

@export var env: Environment

@export var mainmenu_camera : Camera3D
@export var gamemanager : Node3D
@export var gamesequence: Node3D

@export var hallway: MeshInstance3D
@export var door_mesh: MeshInstance3D
@export var door: Node3D
@export var door_ui_node: Node3D

var can_interact_with_door_portal : bool = false
var player_in_illegal_door_portal_spot : bool = false
var player_in_portal_room : bool = false:
	set(value):
		player_in_portal_room = value
		door.player_in_portal_room = value

var player_in_front_of_portal : bool = false

@export var hallway_collision: StaticBody3D

func _ready() -> void:
	PlayerGlobal.player_location = PlayerGlobal.PlayerLoc.MAINROOM
	
	
	#mainmenu_camera.make_current()
	PlayerGlobal.world = $"."

func _physics_process(_delta: float) -> void:
	if PlayerGlobal.player_location == PlayerGlobal.PlayerLoc.MAINROOM:
		if (player_in_front_of_portal or player_in_portal_room):
			can_interact_with_door_portal = true
			door_ui_node.visible = true
			hallway_collision.process_mode = Node.ProcessMode.PROCESS_MODE_INHERIT
		else:
			can_interact_with_door_portal = false
			door_ui_node.visible = false
			hallway_collision.process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED


func _on_portalswitchnotifier_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"player_body") and player_in_front_of_portal:
		player_in_portal_room = true
		print("player in room")
		var mat_hallway = hallway.mesh.surface_get_material(0)
		mat_hallway.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_DISABLED
		
		var door_mat_1 = door_mesh.mesh.surface_get_material(0)
		door_mat_1.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_DISABLED
		
		var door_mat_2 = door_mesh.mesh.surface_get_material(1)
		door_mat_2.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_DISABLED
		
		var door_mat_3 = door_mesh.mesh.surface_get_material(2)
		door_mat_3.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_DISABLED

func _on_portalswitchnotifier_body_exited(body: Node3D) -> void:
	if body.is_in_group(&"player_body") and player_in_front_of_portal:
		player_in_portal_room = false
		print("player not in room")
		var mat_hallway = hallway.mesh.surface_get_material(0)
		mat_hallway.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_CUSTOM
		mat_hallway.stencil_flags = 1
		mat_hallway.stencil_compare = BaseMaterial3D.StencilCompare.STENCIL_COMPARE_LESS
		mat_hallway.stencil_reference = 1
		
		var door_mat_1 = door_mesh.mesh.surface_get_material(0)
		door_mat_1.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_CUSTOM
		door_mat_1.stencil_flags = 1
		door_mat_1.stencil_compare = BaseMaterial3D.StencilCompare.STENCIL_COMPARE_LESS
		door_mat_1.stencil_reference = 1
		
		var door_mat_2 = door_mesh.mesh.surface_get_material(1)
		door_mat_2.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_CUSTOM
		door_mat_2.stencil_flags = 1
		door_mat_2.stencil_compare = BaseMaterial3D.StencilCompare.STENCIL_COMPARE_LESS
		door_mat_2.stencil_reference = 1
		
		var door_mat_3 = door_mesh.mesh.surface_get_material(2)
		door_mat_3.stencil_mode = BaseMaterial3D.StencilMode.STENCIL_MODE_CUSTOM
		door_mat_3.stencil_flags = 1
		door_mat_3.stencil_compare = BaseMaterial3D.StencilCompare.STENCIL_COMPARE_LESS
		door_mat_3.stencil_reference = 1


func _on_playernotoutsideportalnotifier_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"player_body") and !player_in_portal_room:
		hallway.visible = false

func _on_playernotoutsideportalnotifier_body_exited(body: Node3D) -> void:
	if body.is_in_group(&"player_body") and !player_in_portal_room:
		hallway.visible = true


func _on_playeroutsideportalnotifier_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"player_body"):
		player_in_front_of_portal = true
		door.key.visible = true
		door.can_interact_with_door = true
		

func _on_playeroutsideportalnotifier_body_exited(body: Node3D) -> void:
	if body.is_in_group(&"player_body"):
		player_in_front_of_portal = false
