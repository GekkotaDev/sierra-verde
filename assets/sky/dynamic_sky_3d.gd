@tool extends WorldEnvironment

const DAYLIGHT_CYCLE_NORMALIZED = 360

@export var enabled: bool = true

@export var _timeline: AnimationPlayer


@onready var astro_angle: float:
    get:
        var cycles = _timeline.current_animation_length / DAYLIGHT_CYCLE_NORMALIZED
        var timestamp = _timeline.current_animation_position / cycles
        return timestamp

@onready var daylight_cycle_speed: float:
    get:
        return _timeline.speed_scale
    set(scale):
        _timeline.speed_scale = scale


func _process(_delta: float) -> void:
    if Engine.is_editor_hint() and enabled and not _timeline.is_playing():
        _timeline.play("daylight_cycle")
