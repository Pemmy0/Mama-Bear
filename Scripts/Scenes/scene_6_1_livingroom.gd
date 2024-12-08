extends Node

@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")
@onready var dada_trigger = %"Dada Trigger"

@export var marker: Marker2D

var lines = ObjectLibrary.dada_lines_1

func _ready():
	ObjectLibrary.timmy_move_allowed = false
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_box_right.tscn")
	%TV.play("Default")
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact"):
		if MonologueManager.dialog_ended:
			return
		MonologueManager.start_dialog(marker.global_position, lines, speech_sound)
