extends Area2D

@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")
@export var player: CharacterBody2D
@export var marker: Marker2D

var test = ObjectLibrary.trigger_livingroom_4

var current_index = 0
var key_holder = []
var value_holder = []

var speaker_location
var msg: Array[String]
var n = 0

var player_in_area = false

func _ready():
	key_holder = test.keys()
	value_holder = test.values()
	
	for text in value_holder:
		n += 1
		msg.append(value_holder[n-1])
		
func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact") && player_in_area:
		if DialogueManager.can_advance_line:
			go_to_next()

func _on_body_entered(body):
	go_to_next()
	player_in_area = true
	if body.is_in_group("player") && !ObjectLibrary.has_interacted_livingroom_4:
		if MonologueManager.dialog_ended:
			return
		if DialogueManager.can_advance_line:
			go_to_next()
		DialogueManager.start_dialog(msg)
		ObjectLibrary.has_interacted_livingroom_4 = true
		
func _on_body_exited(_body):
	current_index = -1
	DialogueManager.text_box_position = Vector2.ZERO
	DialogueManager.dialog_ended = false
	player_in_area = false
		
func go_to_next():
		if current_index < len(key_holder):
			var key = key_holder[current_index]
			
			if "Mama" in key:
				DialogueManager.text_box_position = Vector2.ZERO
			elif "Dada" in key:
				DialogueManager.text_box_position = marker.global_position
			else:
				DialogueManager.text_box_position = player.global_position
				
			current_index += 1
