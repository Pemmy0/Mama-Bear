extends Area2D

func _ready():
	%CollisionShape2D.disabled = false
	
func _on_body_entered(body):
	%CollisionShape2D.disabled = true
	scene_transition()

func scene_transition():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_6_4_livingroom.tscn")
