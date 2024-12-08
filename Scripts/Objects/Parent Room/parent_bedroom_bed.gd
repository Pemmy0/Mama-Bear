extends Area2D

var lines = ObjectLibrary.parent_bedroom_bed

func _on_body_entered(body):
	ObjectLibrary.has_interacted_parent_bedroom_bed = true
