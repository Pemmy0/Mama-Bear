extends Area2D

@onready var pointer = %Pointer
@onready var audio_stream_player = $AudioStreamPlayer

var player

func _ready():
	ObjectLibrary.has_interacted_teddy = false
	player = get_tree().get_first_node_in_group("player")
	if !GlobalPosition.to_livingroom:
		player.animated_sprite_2d.flip_h = true
		player.position.x = GlobalPosition.corridor_stair_position.x - 12
		GlobalPosition.to_livingroom = true
		
	pointer.hide()

func _on_body_entered(_body):
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_box_right.tscn")
	pointer.show()
	pointer.play("pointer")

func _on_body_exited(_body):
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_box.tscn")
	pointer.hide()
	DialogueManager.dialog_ended = false
	
func scene_transition():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	if ObjectLibrary.has_interacted_lizard:
		get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_5_livingroom.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_4_livingroom.tscn")
