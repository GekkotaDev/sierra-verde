extends Node3D

@export var _mesh: MeshInstance3D

@export var mesh: ArrayMesh
@export var collision_area: Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    if mesh:
        _mesh.mesh = mesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    var player: Node3D = null
    var bodies := collision_area.get_overlapping_bodies()

    for body in bodies:
        if not body.is_in_group(GroupsLookupStore.Entities.PLAYERS):
            continue
        player = body
        break
