@abstract class_name PowerupEntity
extends Node3D

@export var entity: PhysicsBody3D


@abstract class PowerupBuilder:
	@abstract func instantiate(user: VehiclePlatform) -> PowerupEntity


@abstract func from_builder()
