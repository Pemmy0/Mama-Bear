extends Area2D

@onready var pointer = %Pointer
var player

func _ready():
	player = get_tree().get_first_node_in_group("player")
	GlobalPosition.to_living_from_kitchen = false
	ObjectLibrary.kitchen_has_entered = true
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
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_6_livingroom.tscn")
