extends CharacterBody2D

@export var SPEED = 85.0
@export var direction: float = 1

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	$AnimatedSprite2D.flip_h = false
	$AnimatedSprite2D.play("Mama n Timmy Idle")

func _physics_process(delta):
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
		animated_sprite_2d.play("Mama n Timmy")
	elif !ObjectLibrary.mama_move_allowed:
		animated_sprite_2d.play("Mama n Timmy Idle")
		
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
