extends Control

@export var animation_player: AnimationPlayer


func _ready() -> void:
	SoundManager.stop_music(1.0)
	animation_player.play("loader")
