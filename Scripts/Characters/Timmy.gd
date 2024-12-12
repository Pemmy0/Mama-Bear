extends CharacterBody2D
class_name Timmy

@export var SPEED = 75.0
@export var sfx_footstep: AudioStream
@export var sfx_interact: AudioStream

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var choice = $Choice
@onready var button_1 = $Choice/Choice1/Button1
@onready var button_2 = $Choice/Choice2/Button2
@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")
@onready var audio_stream_player = $AudioStreamPlayer

var footstep_frames: Array = [0, 4]

var move_allowed = true
var interactable = false
var choice_one_choosen = false
var temp_choice_lines1: Array[String]
var temp_choice_lines2: Array[String]

var animation_idle: String
var animation_walk: String

var text_position: Vector2

func _ready():
	start_choice()
	
func _process(delta):
	if choice_one_choosen:
		ObjectLibrary.trigger_phone_notification = true

func _physics_process(_delta):
	var direction = Input.get_axis("Left", "Right")
	movement(direction)
	update_animation(direction)
	move_and_slide()
	interact()
	
	if (
		Input.is_action_just_pressed("Interact") &&
		!MonologueManager.is_dialog_active && MonologueManager.dialog_ended &&
		interactable
	):
		MonologueManager.choice_start = true
	
	start_choice()
	
	move_allowed = !(MonologueManager.is_dialog_active || MonologueManager.choice_start || 
		DialogueManager.is_dialog_active || !ObjectLibrary.timmy_move_allowed)
		
	if !ObjectLibrary.timmy_box:
		animation_idle = "Idle"
		animation_walk = "Walk"
	else:
		animation_idle = "Idle Box"
		animation_walk = "Walk Box"
	
func movement(direction):
	if direction and move_allowed:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
func update_animation(direction):
	if move_allowed:
		if direction != 0: 
			animated_sprite_2d.play(animation_walk)
		elif velocity.x == 0:
			animated_sprite_2d.play(animation_idle)
			
		if direction == 1:
			animated_sprite_2d.flip_h = false
		elif direction == -1:
			animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.play(animation_idle)
		
func interact():
	%InteractBox.disabled = !(Input.is_action_just_pressed("Interact"))
		
func start_choice():
	if MonologueManager.choice_start:
		choice.show()
		if !button_1.has_focus() and !button_2.has_focus():
			button_1.grab_focus()
	else:
		choice.hide()
		button_1.release_focus()
		button_2.release_focus()
		
func _input(event):
	if event.is_action_pressed("Left") and button_1.has_focus():
		button_2.grab_focus()
	elif event.is_action_pressed("Right") and button_2.has_focus():
		button_1.grab_focus()
		
func load_sfx(sfx_to_load):
	if audio_stream_player.stream != sfx_to_load:
		audio_stream_player.stop()
		audio_stream_player.stream = sfx_to_load

#choice 1
func _on_button_1_pressed():
	choice_one_choosen = true
	if !ObjectLibrary.use_them_dialogue:
		MonologueManager.start_dialog(global_position, temp_choice_lines1, speech_sound)
	else:
		DialogueManager.start_dialog(temp_choice_lines1)
	MonologueManager.choice_start = false
	interactable = false
		
#choice 2
func _on_button_2_pressed():
	MonologueManager.start_dialog(global_position, temp_choice_lines2, speech_sound)
	MonologueManager.choice_start = false
	interactable = false
	
func _on_interact_area_entered(area):
	if area.is_in_group("objects"):
		if MonologueManager.dialog_ended:
			return
		MonologueManager.start_dialog(global_position, area.lines, speech_sound)
		
	if area.is_in_group("objects multiple"):
		if MonologueManager.dialog_ended:
			return
		MonologueManager.start_dialog(global_position, area.lines, speech_sound)
		if area.has_multiple_lines:
			ObjectLibrary.dada_count += 1
		
	if area.is_in_group("interactable"):
		interactable = true
		temp_choice_lines1 = area.choice_lines1
		temp_choice_lines2 = area.choice_lines2
		
	if area.is_in_group("doors"):
		if !ObjectLibrary.has_transitioned:
			ObjectLibrary.has_transitioned = true
			area.scene_transition()
		
	if area.is_in_group("special doors"):
		if (
			ObjectLibrary.bathroom_has_entered && ObjectLibrary.kitchen_has_entered ||
			ObjectLibrary.has_interacted_teddy || ObjectLibrary.has_interacted_lizard
		):
			if !ObjectLibrary.has_transitioned:
				ObjectLibrary.has_transitioned = true
				area.scene_transition()
		else:
			if MonologueManager.dialog_ended:
				return
			MonologueManager.start_dialog(global_position, area.lines, speech_sound)
			
	if area.is_in_group("special table"):
		if !ObjectLibrary.timmy_box:
			if MonologueManager.dialog_ended:
				return
			MonologueManager.start_dialog(global_position, area.lines, speech_sound)
		else:
			area.scene_transition()


func _on_animated_sprite_2d_frame_changed():
	if animated_sprite_2d.animation == "Idle" || animated_sprite_2d.animation == "Idle Box":
		return
	load_sfx(sfx_footstep)
	if animated_sprite_2d.frame in footstep_frames: audio_stream_player.play()
