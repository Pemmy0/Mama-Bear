extends Node

@onready var text_box_scene = preload("res://Scenes/UI/text_box.tscn")
@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")

var dialog_lines: Array[String] = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var sfx: AudioStream

var is_dialog_active = false
var can_advance_line = false

var choice_start = false
var dialog_ended = false

func start_dialog(lines: Array[String]):
	if is_dialog_active:
		return
		
	dialog_lines = lines
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index], speech_sound)
	can_advance_line = false

func _on_text_box_finished_displaying():
	can_advance_line = true
	
func _unhandled_input(event):
	if (
		event.is_action_pressed("Interact") &&
		is_dialog_active &&
		can_advance_line
	):
		text_box.queue_free()
		
		current_line_index += 1
		
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			dialog_ended = true
			return
			
		_show_text_box()
