extends Node

func _ready():
	$Environment/Mama.play("Default")
	GlobalPosition.current_room = "parentbedroom"
	RoomAmbience.play_room_ambience()
