extends Node

@onready var tv = %TV

func _ready():
	GlobalPosition.current_room = "livingroom2"
	RoomAmbience.play_room_ambience()
	ObjectLibrary.timmy_move_allowed = true
	tv.play("Default")
