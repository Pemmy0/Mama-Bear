extends Area2D

var lines = ObjectLibrary.bedroom_lizard

func _on_body_entered(body):
	ObjectLibrary.has_interacted_lizard = true
