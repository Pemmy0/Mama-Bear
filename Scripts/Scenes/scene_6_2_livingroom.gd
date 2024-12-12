extends Node

@onready var dada = $"Main Environment/Dada"

@export var mama_marker: Marker2D
@export var mama_marker_2: Marker2D
@export var dada_marker: Marker2D
@export var bean_marker: Marker2D

var test = ObjectLibrary.final_fight_1

var key_holder = []
var value_holder = []

var speaker_location
var msg: Array[String]
var n = 0
var current_index = 0
var ending_timer = 0

var player_in_area = false
var has_interacted = false
var press_once = false
var stop_loop = false

#animation bool
var hand_raise_once = true

func _ready():
	GlobalPosition.current_room = "livingroom2"
	DialogueManager.text_box_scene = preload("res://Scenes/UI/text_box.tscn")
	DialogueManager.dialog_ended = false
	DialogueManager.can_advance_line = false
	ObjectLibrary.has_transitioned = false
	assign_new_line()
	go_to_next()
	%TV.play("Default")
	dada.play("Dad n Bean")
		
func _process(delta):
	if ending_timer > 0:
		ending_timer -= delta
	
	if test == ObjectLibrary.final_fight_1:
		if current_index >= 4 && test == ObjectLibrary.final_fight_1:
			DialogueManager.text_box_scene = preload("res://Scenes/UI/text_box_right.tscn")
		
	if (
		Input.is_action_just_pressed("Interact") &&
		!DialogueManager.is_dialog_active && DialogueManager.dialog_ended
	):
		if test == ObjectLibrary.final_fight_1:
			ObjectLibrary.mama_move_allowed = true
			clear_all()
			test = ObjectLibrary.final_fight_2
			assign_new_line()
		
		if test == ObjectLibrary.final_fight_2 && current_index > 1:
			ending_timer += 1
			
	if (
		ending_timer > 0.01 && ending_timer < 0.03 &&
		test == ObjectLibrary.final_fight_2
	):
		scene_transition()

func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact"):
		if DialogueManager.can_advance_line:
			current_index += 1
			go_to_next()
		if DialogueManager.dialog_ended:
			return
		DialogueManager.start_dialog(msg)
		press_once = true
		
		print(current_index)
		
		#Animation Trigger
		if test == ObjectLibrary.final_fight_1:
			if current_index == 4 && hand_raise_once:
				dada.play("Raise Hand")
		elif test == ObjectLibrary.final_fight_2: 
			if current_index == 3:
				dada.play("Lower Hand")

func go_to_next():
	if current_index < len(key_holder):
		var key = key_holder[current_index]
		
		if "Mama" in key:
			if test == ObjectLibrary.final_fight_1:
				DialogueManager.text_box_position = mama_marker.global_position
			elif test == ObjectLibrary.final_fight_2:
				DialogueManager.text_box_position = mama_marker_2.global_position
		elif "Dada" in key:
			DialogueManager.text_box_position = dada_marker.global_position
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
	
func scene_transition():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_6_3_livingroom.tscn")

func _on_dada_animation_finished():
	if dada.animation == "Dad n Bean":
		if !press_once:
			dada.play("Dad n Bean")
		else:
			dada.play("Bean cry")
	elif dada.animation == "Raise Hand":
		hand_raise_once = false
		dada.play("Raise Hold")
	elif dada.animation == "Raise Hold":
		if !stop_loop:
			dada.play("Raise Hold")
	elif dada.animation == "Lower Hand":
		dada.play("Bean cry")
