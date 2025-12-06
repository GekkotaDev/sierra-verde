extends Control


func _ready() -> void:
	SceneManager.change_scene(preload("res://scenes/boot_intro/boot_intro.tscn"))
