class_name WheelSpin3D extends "res://addons/gevp/scripts/wheel_smoke.gd"


signal on_wheelspin(wheel: Wheel)


func in_slip(wheel: Wheel):
	return absf(wheel.slip_vector.x) > lateral_slip_threshold or absf(wheel.slip_vector.y) > longitudinal_slip_threshold


func _process(delta):
	super (delta)

	for wheel in vehicle.wheel_array:
		if not in_slip(wheel): break
		on_wheelspin.emit(wheel)
