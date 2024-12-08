extends Area2D

@export var marker: Marker2D

@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")
var lines = ObjectLibrary.trigger_bathroom_1
var player

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _on_body_entered(body):
	if body.is_in_group("player") && !ObjectLibrary.has_interacted_bathroom_1:
		if MonologueManager.dialog_ended:
			return
		MonologueManager.start_dialog(marker.global_position, lines, speech_sound)
		ObjectLibrary.has_interacted_bathroom_1 = true

func _on_body_exited(_body):
	MonologueManager.dialog_ended = false
