extends CharacterBody2D

@export var SPEED = 85.0
@export var direction: float
@export var walk_time: float

@onready var animated_sprite_2d = $AnimatedSprite2D

var can_walk = false

func _ready():
	animated_sprite_2d.play("Idle")

func _physics_process(delta):
	if MonologueManager.can_advance_line:
		if walk_time > 0 && can_walk:
			walk_time -= delta
		elif walk_time <= 0:
			direction = 0
			can_walk = false
		
	dada_walk()
	update_animation()
	
	move_and_slide()
	
func dada_walk():
	if can_walk:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact"):
		if MonologueManager.can_advance_line:
			can_walk = true

func update_animation():
	if can_walk: 
		animated_sprite_2d.play("Walk")
	elif !can_walk:
		animated_sprite_2d.play("Idle")
		
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
