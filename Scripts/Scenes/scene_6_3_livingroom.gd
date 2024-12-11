extends Node

func _ready():
	GlobalPosition.current_room = "livingroom2"
	%Dada.play("Default")
	%TV.play("Default")
	$"Main Environment/Environment/Mama/AnimatedSprite2D".play("Idle")
