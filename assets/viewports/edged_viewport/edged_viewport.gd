@tool
extends SubViewportContainer


@export_group("Camera")
@export var REFERENCE_CAMERA: NodePath
@export var POSITION: Vector3 = Vector3.ZERO
@export var ROTATION: Vector3 = Vector3.ZERO

@onready var followed_camera = get_node(REFERENCE_CAMERA) as Camera3D
@onready var viewport_camera = %ViewportCamera as Camera3D


func _setup_camera():
	pass


func _process(_delta: float) -> void:
	if not followed_camera or Engine.is_editor_hint():
		viewport_camera.transform.origin = POSITION
		viewport_camera.rotation_degrees = ROTATION
		_setup_camera()

	if not Engine.is_editor_hint() and followed_camera:
		viewport_camera.rotation = followed_camera.rotation
		viewport_camera.transform = followed_camera.transform
		viewport_camera.attributes = followed_camera.attributes

		viewport_camera.environment = followed_camera.environment
		viewport_camera.fov = followed_camera.fov
		viewport_camera.doppler_tracking = followed_camera.doppler_tracking
		viewport_camera.projection = followed_camera.projection
		viewport_camera.near = followed_camera.near
		viewport_camera.far = followed_camera.far
