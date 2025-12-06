class_name VehicleAudio
extends "res://addons/gevp/scripts/engine_sound.gd"

@export var rpm_audio: Dictionary[int, AudioStream] = { }


func _ready() -> void:
	# super()
	rpm_audio.sort()


func _physics_process(delta: float):
	# Failed attempt at better audio
	# map_rpm(
	# 	rpm_audio,
	# 	func(rpm: int, sound: AudioStream):
	# 		if rpm == sample_rpm:
	# 			return

	# 		sample_rpm = rpm
	# 		stream = sound
	# 		play()
	# 		print(sound)

	# 		if not stream:
	# 			print("null?")
	# )

	super(delta)


func map_rpm(rpm_audio_reference: Dictionary[int, AudioStream], callback: Callable):
	for rpm in rpm_audio_reference:
		var sound := rpm_audio_reference[rpm]

		if vehicle.motor_rpm >= rpm:
			callback.call(rpm, sound)
