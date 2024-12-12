extends Node

func _ready():
	$Environment/Mama.play("Default")
	GlobalPosition.current_room = "parentbedroom"
	RoomAmbience.play_room_ambience()
	DialogueManager.can_advance_line = false
	DialogueManager.dialog_ended = false
	MonologueManager.dialog_ended = false
