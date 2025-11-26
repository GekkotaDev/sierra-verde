class_name BuildingIgress3D extends Area3D

@export var excluded_groups: Array[String] = []
@export var included_groups: Array[String] = []

signal excluded_ingress(body: Node3D)
signal included_ingress(body: Node3D)


func _process(_delta: float) -> void:
    if not has_overlapping_bodies(): return
    var bodies := get_overlapping_bodies()

    for body in bodies:
        if not body.is_in_group("teams/player"):
            excluded_ingress.emit(body)
            continue
        included_ingress.emit(body)
