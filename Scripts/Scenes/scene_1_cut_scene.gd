extends Node2D

@onready var cutscene = $Cutscene
@onready var audio_stream_player = $AudioStreamPlayer

@export var sfx_footstep: AudioStream
@export var sheet_rustling: AudioStream
@export var sfx_scratch: AudioStream
@export var sfx_hat: AudioStream

var play_cutscene = false
var stop_loop = false
var footstep_frames1: Array = [25]
var footstep_frames2: Array = [3, 7, 11, 15, 18]
var sheet_rustling_frames: Array = [6]
var scratching_frames: Array = [7, 10, 15, 18]
var put_on_hat_frame: Array = [21]

func _ready():
	cutscene.play("Default")
	GlobalPosition.current_room = "bedroom"
	RoomAmbience.play_room_ambience()
	ObjectLibrary.has_played_ambience = true
	
func _unhandled_input(event):
	if Input.is_anything_pressed():
		stop_loop = true
		
func load_sfx(sfx_to_load):
	if audio_stream_player.stream != sfx_to_load:
		audio_stream_player.stop()
		audio_stream_player.stream = sfx_to_load
		
func _on_cutscene_animation_finished():
	if cutscene.animation == "Default":
		if !stop_loop:
			cutscene.play("Default")
		else:
			$AnimationPlayer.play("start animation")
			cutscene.play("Waking Up")
	elif cutscene.animation == "Waking Up":
		cutscene.play("Walk And Hat")
	elif cutscene.animation == "Walk And Hat":
		get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_1_bedroom.tscn")

func _on_cutscene_frame_changed():
	if cutscene.animation == "Default": return
	if cutscene.animation == "Waking Up":
		if cutscene.frame in sheet_rustling_frames: 
			load_sfx(sheet_rustling)
			audio_stream_player.play()
		elif cutscene.frame in scratching_frames:
			load_sfx(sfx_scratch)
			audio_stream_player.play()
		elif cutscene.frame in footstep_frames1: 
			load_sfx(sfx_footstep)
			audio_stream_player.play()
	elif cutscene.animation == "Walk And Hat":
		if cutscene.frame in footstep_frames2: 
			load_sfx(sfx_footstep)
			audio_stream_player.play()
		elif cutscene.frame in put_on_hat_frame: 
			load_sfx(sfx_hat)
			audio_stream_player.play()
