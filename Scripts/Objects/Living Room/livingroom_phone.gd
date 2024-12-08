extends Area2D

var lines = ObjectLibrary.livingroom_phone
var choice_lines1 = ObjectLibrary.livingroom_phone_choice1
var choice_lines2 = ObjectLibrary.livingroom_phone_choice2

var index = 0

@export var player: CharacterBody2D
@export var marker: Marker2D

func _ready():
	%Pointer.hide()
	%Pointer.play("pointer")
	
func _unhandled_input(event):
	if (
		Input.is_action_just_pressed("Interact") && DialogueManager.can_advance_line &&
		ObjectLibrary.trigger_phone_notification
	):
		index += 1
		print(index)
		if index == 1 && ObjectLibrary.trigger_phone_notification:
			print("phone notif")
			$AudioStreamPlayer2D.play()
			DialogueManager.text_box_position = marker.global_position
		elif index == 6 && ObjectLibrary.trigger_phone_notification:
			scene_transition()
		else:
			DialogueManager.text_box_position = player.global_position
			
func scene_transition():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_6_1_livingroom.tscn")

func _on_body_entered(body):
	%Pointer.show()
	index = 0
	ObjectLibrary.use_them_dialogue = true

func _on_body_exited(body):
	%Pointer.hide()
	index = 0
	ObjectLibrary.trigger_phone_notification = false
	MonologueManager.dialog_ended = false
	ObjectLibrary.use_them_dialogue = false
