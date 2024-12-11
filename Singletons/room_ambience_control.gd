extends Node

@onready var audio_stream_player = $AudioStreamPlayer

var bedroom = preload("res://SFX/Room Ambience/Bedroom.mp3")
var corriror = preload("res://SFX/Room Ambience/Corridor.mp3")
var corriror2 = preload("res://SFX/Room Ambience/Corridor Scene 4.mp3")
var livingroom = preload("res://SFX/Room Ambience/Living Room.mp3")
var livingroom2 = preload("res://SFX/Room Ambience/Living Room Scene 4.mp3")
var kitchen = preload("res://SFX/Room Ambience/Kitchen.mp3")
var kitchen2 = preload("res://SFX/Room Ambience/Kitchen Scene 4.mp3")
var bathroom2 = preload("res://SFX/Room Ambience/Bathroom Scene 4.mp3")
var parentroom = preload("res://SFX/Room Ambience/Parent Room.mp3")

func load_sfx(sfx_to_load):
	if audio_stream_player.stream != sfx_to_load:
		audio_stream_player.stop()
		audio_stream_player.stream = sfx_to_load
		
func play_room_ambience():
	match GlobalPosition.current_room:
		"bedroom":
			load_sfx(bedroom)
		"corridor":
			load_sfx(corriror)
		"corridor2":
			load_sfx(corriror2)
		"livingroom":
			load_sfx(livingroom)
		"livingroom2":
			load_sfx(livingroom2)
		"kitchen":
			load_sfx(kitchen)
		"kitchen2":
			load_sfx(kitchen2)
		"bathroom":
			load_sfx(kitchen)
		"bathroom2":
			load_sfx(bathroom2)
		"parentbedroom":
			load_sfx(parentroom)
		_:
			print("Ended")
	audio_stream_player.play()
