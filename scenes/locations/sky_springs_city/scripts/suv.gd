extends RigidBody3D

@export var dialog: String

@onready var debounced := Debouncer.new(
	func():
		if Dialogic.current_timeline:
			return
		Dialogic.start(dialog),
	0.1
)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies := get_colliding_bodies()
	var player: Node3D

	#for body in bodies:
	#if not body.is_in_group(GroupsLookupStore.Entities.PLAYERS):
	#continue
	#player = body
	#
	#if player == null: return

	if bodies.size() < 1:
		return

	debounced.bounce()


func _on_test():
	print("timed out")
