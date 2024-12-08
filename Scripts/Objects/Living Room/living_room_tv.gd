extends Area2D

@onready var object = %Object

var lines = ObjectLibrary.living_room_tv

func _ready():
	object.play("Default")
