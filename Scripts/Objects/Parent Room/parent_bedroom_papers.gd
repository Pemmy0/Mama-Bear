extends Area2D

var lines = ObjectLibrary.parent_bedroom_papers

func _ready():
	%Pointer.hide()
	%Pointer.play("pointer")

func _on_body_entered(body):
	%Pointer.show()
	
func _on_body_exited(body):
	%Pointer.hide()
