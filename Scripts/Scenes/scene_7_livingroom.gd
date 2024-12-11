extends Node

@onready var dada = $"Main Environment/Dada"

@export var mama_marker: Marker2D
@export var bean_marker: Marker2D

var test = ObjectLibrary.final_fight_5

var key_holder = []
var value_holder = []

var speaker_location
var msg: Array[String]
var n = 0
var current_index = 0
var ending_timer = 0

var player_in_area = false
var has_interacted = false
var play_dialogue = true

func _ready():
	ObjectLibrary.mama_move_allowed = false
	DialogueManager.text_box_scene = preload("res://Scenes/UI/text_box_right.tscn")
	DialogueManager.dialog_ended = false
	DialogueManager.can_advance_line = false
	assign_new_line()
	go_to_next()
	%Dada.play("Default")
	%TV.play("Default")

func _process(delta):
	if ending_timer > 0:
		ending_timer -= delta
		
	if (
		Input.is_action_just_pressed("Interact") &&
		!DialogueManager.is_dialog_active && DialogueManager.dialog_ended
	):
		if test == ObjectLibrary.final_fight_5:
			ObjectLibrary.mama_move_allowed = true

func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact") && play_dialogue:
		if DialogueManager.can_advance_line:
			current_index += 1
			go_to_next()
		if DialogueManager.dialog_ended:
			return
		DialogueManager.start_dialog(msg)

		print(current_index)

func go_to_next():
	if current_index < len(key_holder):
		var key = key_holder[current_index]
		
		if "Mama" in key:
			DialogueManager.text_box_position = mama_marker.global_position
		elif "Dada" in key:
			DialogueManager.text_box_position = Vector2.ZERO
		else:
			DialogueManager.text_box_position = bean_marker.global_position

func assign_new_line():
	key_holder = test.keys()
	value_holder = test.values()
	
	for text in value_holder:
		n += 1
		msg.append(value_holder[n-1])
	
func clear_all():
	key_holder.clear()
	value_holder.clear()
	msg.clear()
	n = 0
	current_index = 0
