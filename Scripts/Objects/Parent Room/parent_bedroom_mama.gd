extends Area2D

@onready var pointer = %Pointer
@onready var object = %Object
@export var player: CharacterBody2D
@export var marker: Marker2D

var test = ObjectLibrary.parent_bedroom_mama_1

var current_index = 0
var key_holder = []
var value_holder = []

var speaker_location
var msg: Array[String]
var n = 0

var player_in_area = false
var has_interacted = false

func _ready():
	key_holder = test.keys()
	value_holder = test.values()
	pointer.hide()
	object.play("Default")
	$Cols.disabled = false
	
	for text in value_holder:
		n += 1
		msg.append(value_holder[n-1])

func _unhandled_input(_event):
	if (
		Input.is_action_just_pressed("Interact") && player_in_area && !$Cols.disabled
		&& ObjectLibrary.has_interacted_parent_bedroom_bed
	):
		has_interacted = true
		if DialogueManager.can_advance_line:
			current_index += 1
			go_to_next()
		if DialogueManager.dialog_ended:
			return
		DialogueManager.start_dialog(msg)

func go_to_next():
		if current_index < len(key_holder):
			var key = key_holder[current_index]
			
			if "Mama" in key:
				DialogueManager.text_box_position = marker.global_position
			elif "Dada" in key:
				DialogueManager.text_box_position = marker.global_position
			else:
				DialogueManager.text_box_position = player.global_position

func _on_body_entered(_body):
	if !$Cols.disabled && ObjectLibrary.has_interacted_parent_bedroom_bed:
		pointer.show()
	pointer.play("pointer")
	current_index = 0
	go_to_next()
	player_in_area = true

func _on_body_exited(_body):
	pointer.hide()
	if DialogueManager.dialog_ended && has_interacted:
		pointer.hide()
		$Cols.disabled = true
	current_index = 0
	DialogueManager.text_box_position = Vector2.ZERO
	DialogueManager.dialog_ended = false
	player_in_area = false
