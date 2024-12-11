extends Node

@onready var audio_stream_player = %AudioStreamPlayer
@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")

@export var sfx_doorbell: AudioStream
@export var marker: Marker2D

var event_trigger_timer = 2
var lines = ObjectLibrary.trigger_livingroom_3

func _ready():
	GlobalPosition.current_room = "livingroom2"
	RoomAmbience.play_room_ambience()
	event_trigger_timer = 2
	ObjectLibrary.timmy_move_allowed = false
		
func _process(delta):
	if event_trigger_timer > 0:
		event_trigger_timer -= delta
	
	if ObjectLibrary.has_interacted_lizard:
		if event_trigger_timer > 1 && event_trigger_timer < 1.1:
			load_sfx(sfx_doorbell)
			audio_stream_player.play()
		elif event_trigger_timer > 0 && event_trigger_timer < 0.1:
			ObjectLibrary.timmy_move_allowed = true
			if MonologueManager.dialog_ended:
				return
			MonologueManager.start_dialog(Vector2(-4, 152), lines, speech_sound)

func load_sfx(sfx_to_load):
	if audio_stream_player.stream != sfx_to_load:
		audio_stream_player.stop()
		audio_stream_player.stream = sfx_to_load
