extends Area2D

var lines = ObjectLibrary.parent_bedroom_teddy

func _on_body_entered(body):
	ObjectLibrary.has_interacted_teddy = true
