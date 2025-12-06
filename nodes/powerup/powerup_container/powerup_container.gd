extends Node3D

@export var powerups: Array[PowerupEntity]
@export var mesh: ArrayMesh
@export var collision_area: Area3D

@export_group("Dependencies")
@export var _mesh: MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if mesh and _mesh:
		_mesh.mesh = mesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var receiver: Node3D = null
	var bodies := collision_area.get_overlapping_bodies()

	for body in bodies:
		if body.is_in_group(GroupsLookupStore.Entities.ID):
			receiver = body
			break

	if not receiver:
		return

	var context = receiver.get("powerups") as PowerupContext
