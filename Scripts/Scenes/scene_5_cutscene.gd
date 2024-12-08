extends Node

@onready var audio_stream_player = $AudioStreamPlayer

@export var player: CharacterBody2D
@export var marker: Marker2D
@export var door_open: AudioStream
@export var door_close: AudioStream

var test = ObjectLibrary.living_room_delivery

var current_index = 0
var key_holder = []
var value_holder = []

var speaker_location
var msg: Array[String]
var n = 0

var ending_timer = 0

var start_tansition = false

func _ready():
	DialogueManager.text_box_scene = preload("res://Scenes/UI/text_box_right.tscn")
	ObjectLibrary.timmy_move_allowed = false
	key_holder = test.keys()
	value_holder = test.values()
	go_to_next()
	
	for text in value_holder:
		n += 1
		msg.append(value_holder[n-1])
		
func _process(delta):
	if ending_timer > 0:
		ending_timer -= delta
		
	if (
		Input.is_action_just_pressed("Interact") &&
		!DialogueManager.is_dialog_active && DialogueManager.dialog_ended
	):
		DialogueManager.choice_start = true
		
	if ending_timer > 0.01 && ending_timer < 0.03:
		scene_transition()

func _unhandled_input(_event):
	if Input.is_action_just_pressed("Interact"):
		if DialogueManager.can_advance_line:
			current_index += 1
			go_to_next()
		if DialogueManager.dialog_ended:
			return
		DialogueManager.start_dialog(msg)
		
	if DialogueManager.choice_start:
		ending_timer = 1
		DialogueManager.choice_start = false

func load_sfx(sfx_to_load):
	if audio_stream_player.stream != sfx_to_load:
		audio_stream_player.stop()
		audio_stream_player.stream = sfx_to_load

func go_to_next():
		if current_index < len(key_holder):
			var key = key_holder[current_index]
			
			if "Mama" in key:
				DialogueManager.text_box_position = marker.global_position
			elif "Dada" in key:
				DialogueManager.text_box_position = marker.global_position
			elif "Delivery" in key:
				DialogueManager.text_box_position = marker.global_position
			else:
				DialogueManager.text_box_position = player.global_position
			
func scene_transition():
	load_sfx(door_close)
	audio_stream_player.pitch_scale += randf_range(-0.2, 0.2)
	audio_stream_player.play()
	DialogueManager.text_box_scene = preload("res://Scenes/UI/text_box.tscn")
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_5_1_livingroom.tscn")
