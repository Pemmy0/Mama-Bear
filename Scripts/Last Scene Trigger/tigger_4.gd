extends Area2D

func _ready():
	ObjectLibrary.mama_move_allowed = false
	
func _on_body_entered(body):
	scene_transition()
	
func scene_transition():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_7_livingroom.tscn")
