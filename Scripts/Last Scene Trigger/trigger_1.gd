extends Area2D

func _ready():
	%CollisionShape2D.disabled = false
	
func _on_body_entered(body):
	ObjectLibrary.call_final_2 = true
	DialogueManager.dialog_ended = false
	%CollisionShape2D.disabled = true
