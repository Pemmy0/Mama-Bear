extends CharacterBody2D

@export var SPEED = 100

@onready var animated_sprite_2d = $AnimatedSprite2D

var direction: float = 1
var walk_time: float = 4
var allow_walk = false

func _ready():
	animated_sprite_2d.play("Idle")
	allow_walk = true

func _physics_process(delta):
	if walk_time > 0:
		walk_time -= delta
	elif walk_time <= 0:
		direction = 0
		allow_walk = false
		
	mama_walk()
	update_animation()
	
	move_and_slide()
	
func mama_walk():
	if allow_walk:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func update_animation():
	if allow_walk: 
		animated_sprite_2d.play("Cry Walk")
	elif !allow_walk:
		animated_sprite_2d.play("Idle")
		
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
