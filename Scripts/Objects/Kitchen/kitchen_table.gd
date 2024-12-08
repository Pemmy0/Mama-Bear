extends Area2D

var lines = ObjectLibrary.kitchen_table

func scene_transition():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_6_kitchen.tscn")
