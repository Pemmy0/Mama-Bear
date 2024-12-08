extends Area2D

@onready var object = %Object

func _on_body_entered(_body):
	object.play("Highlight")

func _on_body_exited(_body):
	object.play("Default")
	MonologueManager.dialog_ended = false
	
