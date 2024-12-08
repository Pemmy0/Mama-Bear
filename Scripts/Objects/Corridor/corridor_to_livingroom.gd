extends Area2D

@onready var pointer = %Pointer
var player

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if !GlobalPosition.to_livingroom:
		player.animated_sprite_2d.flip_h = true
		player.position.x = GlobalPosition.corridor_stair_position.x - 12
		GlobalPosition.to_livingroom = true
		
	pointer.hide()

func _on_body_entered(_body):
	pointer.show()
	pointer.play("pointer")

func _on_body_exited(_body):
	pointer.hide()
	
func scene_transition():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_2_livingroom.tscn")
