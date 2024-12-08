extends Area2D

@onready var pointer = %Pointer
@onready var object = %Object
var lines = ObjectLibrary.kitchen_dada_1
var has_multiple_lines = true

func _ready():
	pointer.hide()
	object.play("Default")

func _process(delta):
	if ObjectLibrary.dada_count > 0:
		lines = ObjectLibrary.kitchen_dada_2
		
func _on_body_entered(_body):
	pointer.show()
	pointer.play("pointer")

func _on_body_exited(_body):
	pointer.hide()
	MonologueManager.dialog_ended = false
