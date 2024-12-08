extends Area2D

var lines = ObjectLibrary.corridor_mirror
@export var player : Node2D
	
func _process(_delta):
	$Reflection.global_position.x = player.global_position.x - 8
	animation()
	
func animation():
	if player.velocity.x != 0: 
		$Reflection.play("Walk")
	else:
		$Reflection.play("Idle")
		
	if player.velocity.x > 0:
		$Reflection.flip_h = false
	elif player.velocity.x < 0:
		$Reflection.flip_h = true
	
