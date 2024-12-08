extends Area2D

var lines = ObjectLibrary.kitchen_trash_bin

func _on_body_entered(body):
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_box_right.tscn")
	
func _on_body_exited(body):
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_box.tscn")
