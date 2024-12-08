extends Camera2D

@export var player: CharacterBody2D

func _physics_process(_delta):
	global_position = player.global_position.round()
