extends Area2D

@onready var pointer = %Pointer
@onready var object = %Object
@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")

@export var marker: Marker2D

var lines = ObjectLibrary.living_room_dada3
var has_multiple_lines = false
var player_in_area = false

func _ready():
	pointer.hide()
	object.play("Default")
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact") && player_in_area:
		if MonologueManager.dialog_ended:
			return
		MonologueManager.start_dialog(marker.global_position, lines, speech_sound)
		
func _on_body_entered(_body):
	pointer.show()
	pointer.play("pointer")
	player_in_area = true

func _on_body_exited(_body):
	pointer.hide()
	MonologueManager.dialog_ended = false
	player_in_area = false
