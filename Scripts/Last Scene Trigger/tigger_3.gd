extends Area2D

@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")
@export var marker_mama: Marker2D
@export var marker_dada: Marker2D

var test = ObjectLibrary.final_fight_4

var current_index = 0
var key_holder = []
var value_holder = []

var speaker_location
var msg: Array[String]
var n = 0

var player_in_area = false

func _ready():
	current_index = 0
	key_holder = test.keys()
	value_holder = test.values()
	
	for text in value_holder:
		n += 1
		msg.append(value_holder[n-1])
		
func _process(delta):
	if (
		Input.is_action_just_pressed("Interact") &&
		!DialogueManager.is_dialog_active && DialogueManager.dialog_ended
	):
		if test == ObjectLibrary.final_fight_4:
			DialogueManager.dialog_ended = false
			ObjectLibrary.mama_move_allowed = true
			print("Dialogue has ended")
		
func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact") && player_in_area:
		if DialogueManager.can_advance_line:
			current_index += 1
			go_to_next()

func _on_body_entered(body):
	ObjectLibrary.mama_move_allowed = false
	go_to_next()
	player_in_area = true
	if MonologueManager.dialog_ended:
		return
	DialogueManager.start_dialog(msg)
		
func _on_body_exited(_body):
	current_index = 0
	DialogueManager.dialog_ended = false
	player_in_area = false
		
func go_to_next():
		if current_index < len(key_holder):
			var key = key_holder[current_index]
			
			if "Mama" in key:
				DialogueManager.text_box_scene = preload("res://Scenes/UI/text_box_right.tscn")
				DialogueManager.text_box_position = marker_mama.global_position
			elif "Dada" in key:
				DialogueManager.text_box_scene = preload("res://Scenes/UI/text_box.tscn")
				DialogueManager.text_box_position = marker_dada.global_position
			else:
				DialogueManager.text_box_position = Vector2.ZERO
