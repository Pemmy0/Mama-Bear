extends Node2D

@onready var cutscene = $Cutscene
@onready var audio_stream_player = $AudioStreamPlayer

@export var sfx_footstep: AudioStream

var play_cutscene = false
var stop_loop = false
var footstep_frames1: Array = [25]
var footstep_frames2: Array = [3, 7, 11, 15, 18]

func _ready():
	cutscene.play("Default")
	
func _process(delta):
	if Input.is_anything_pressed():
		stop_loop = true
		$AnimationPlayer.play("start animation")
		
func load_sfx(sfx_to_load):
	if audio_stream_player.stream != sfx_to_load:
		audio_stream_player.stop()
		audio_stream_player.stream = sfx_to_load
		
func _on_cutscene_animation_finished():
	if cutscene.animation == "Default":
		if !stop_loop:
			cutscene.play("Default")
		else:
			cutscene.play("Waking Up")
	elif cutscene.animation == "Waking Up":
		cutscene.play("Walk And Hat")
	elif cutscene.animation == "Walk And Hat":
		get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_1_bedroom.tscn")

func _on_cutscene_frame_changed():
	if cutscene.animation == "Default": return
	load_sfx(sfx_footstep)
	if cutscene.animation == "Waking Up":
		if cutscene.frame in footstep_frames1: audio_stream_player.play()
	elif cutscene.animation == "Walk And Hat":
		if cutscene.frame in footstep_frames2: audio_stream_player.play()
