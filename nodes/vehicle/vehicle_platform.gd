class_name VehiclePlatform
extends "res://addons/gevp/scripts/vehicle.gd"

@export var camera: Camera3D
@export var middlewares: Array[VehicleMiddleware]
@export var powerups := PowerupContext.new()


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	super(state)

	for middleware in middlewares:
		middleware.integrate_forces(state)


func _physics_process(delta: float) -> void:
	super(delta)

	for middleware in middlewares:
		middleware.process_vehicle(self, camera, delta)
