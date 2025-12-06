extends PowerupEntity

const SCENE = preload("res://nodes/powerup/powerup_entity/boulder/powerup_boulder.tscn")


class PowerupBuilder:
	var entity: RigidBody3D


	func instantiate(user: VehiclePlatform) -> RigidBody3D:
		entity.linear_velocity = user.linear_velocity * 2
		return entity


func from_builder() -> PowerupBuilder:
	var builder := PowerupBuilder.new()

	builder.entity = entity

	return builder


func _physics_process(_delta: float) -> void:
	pass
