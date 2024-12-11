extends Area2D

@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")

var lines = ObjectLibrary.trigger_livingroom_1
var player

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _on_body_entered(body):
	if (body.is_in_group("player") && !ObjectLibrary.has_interacted_livingroom_1
	&& ObjectLibrary.kitchen_has_entered && !ObjectLibrary.bathroom_has_entered):
		if MonologueManager.dialog_ended:
			return
		MonologueManager.start_dialog(player.global_position, lines, speech_sound)
		ObjectLibrary.has_interacted_livingroom_1 = true
		
func _on_body_exited(body):
	MonologueManager.dialog_ended = false
