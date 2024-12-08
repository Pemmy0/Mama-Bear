extends CharacterBody2D

@export var SPEED = 85.0
var direction: float = -1
var walk_time: float = 1

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("Idle")

func _physics_process(delta):
	if walk_time > 0 && ObjectLibrary.mama_move_allowed:
		walk_time -= delta
	elif walk_time <= 0:
		direction = 0
		ObjectLibrary.mama_move_allowed = false
		
	mama_walk()
	update_animation()
	
	move_and_slide()
	
func mama_walk():
	if ObjectLibrary.mama_move_allowed:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func update_animation():
	if ObjectLibrary.mama_move_allowed: 
		animated_sprite_2d.play("Walk")
	elif !ObjectLibrary.mama_move_allowed:
		animated_sprite_2d.play("Idle")
		
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
