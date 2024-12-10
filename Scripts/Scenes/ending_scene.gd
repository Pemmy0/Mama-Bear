extends Control

@onready var speech_sound = preload("res://SFX/Timmy Speech.mp3")
@onready var animation_player = $AnimationPlayer

var lines:Array[String] = ObjectLibrary.ending

var ending_timer:float = 0

func _ready():
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_last_scene.tscn")
	
func _process(delta):
	if (
		Input.is_action_just_pressed("Interact") &&
		!MonologueManager.is_dialog_active && MonologueManager.dialog_ended
	):
		animation_player.play("ending_animation")

func _unhandled_input(event):
	if Input.is_action_just_pressed("Interact"):
		if MonologueManager.dialog_ended:
			return
		MonologueManager.start_dialog($Marker2D.global_position, lines, speech_sound)
