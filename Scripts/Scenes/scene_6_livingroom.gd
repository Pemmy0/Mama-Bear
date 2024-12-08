extends Node

@onready var tv = %TV

func _ready():
	ObjectLibrary.timmy_move_allowed = true
	tv.play("Default")
