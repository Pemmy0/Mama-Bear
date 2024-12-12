extends Node

func _ready():
	ObjectLibrary.timmy_box = false
	$"Environment/Dad Box".play("default")
	ObjectLibrary.has_transitioned = false
