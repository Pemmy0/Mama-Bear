extends Area2D

@onready var pointer = %Pointer
var player

func _ready():
	player = get_tree().get_first_node_in_group("player")
	GlobalPosition.current_room = "kitchen2"
	RoomAmbience.play_room_ambience()
	GlobalPosition.to_living_from_kitchen = false
	ObjectLibrary.kitchen_has_entered = true
	ObjectLibrary.has_transitioned = false
	pointer.hide()

func _on_body_entered(_body):
	pointer.show()
	pointer.play("pointer")

func _on_body_exited(_body):
	pointer.hide()
	
func scene_transition():
	ObjectLibrary.dada_count = 0
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	if ObjectLibrary.timmy_box:
		get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_5_1_livingroom.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_4_livingroom.tscn")
