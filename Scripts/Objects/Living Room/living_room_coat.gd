extends Area2D

var lines = ObjectLibrary.living_room_coat
var choice_lines1 = ObjectLibrary.living_room_coat_choice1
var choice_lines2 = ObjectLibrary.living_room_coat_choice2

func _on_body_entered(body):
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_box_right.tscn")
	
func _on_body_exited(body):
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_box.tscn")
