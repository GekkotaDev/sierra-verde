class_name PowerupContext
extends Node

@export var powerup_queue: Array[PowerupEntity]


func push_to_queue(powerup: PowerupEntity):
	powerup_queue.push_back(powerup)


func pop_from_queue() -> PowerupEntity:
	return powerup_queue.pop_front()
