class_name ControlRouter extends Control


@export var routes: Dictionary[String, Control] = {}


func _on_button_pressed(event: String) -> void:
	match event:
		"play":
			SceneManager.change_scene("res://scenes/locations/sky_springs_city/sky_springs_city.tscn")
