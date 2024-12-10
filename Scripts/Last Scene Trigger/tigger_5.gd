extends Area2D

func _on_body_entered(body):
	scene_transition()

func scene_transition():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/ending_scene.tscn")
