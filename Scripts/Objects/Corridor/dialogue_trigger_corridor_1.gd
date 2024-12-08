extends Area2D

@onready var speech_sound = preload("res://SFX/No Sound.mp3")
@onready var glass_break_sfx = $AudioStreamPlayer

var lines = ObjectLibrary.trigger_corridor_1
var player
var shake_time: float = 0.1
var shake_cam = false

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta):
	if shake_time > 0:
		shake_time -= delta
	else:
		shake_time = 0.2
		shake_cam = false

func _on_body_entered(body):
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_box_right.tscn")
	if body.is_in_group("player") && !ObjectLibrary.has_interacted_corridor_1:
		glass_break_sfx.play()
		if MonologueManager.dialog_ended:
			return
		MonologueManager.start_dialog(Vector2(530, 154), lines, speech_sound)
		ObjectLibrary.has_interacted_corridor_1 = true
		if shake_time > 0:
			shake_cam = true
		
func _on_body_exited(body):
	MonologueManager.text_box_scene = preload("res://Scenes/UI/text_box.tscn")
	MonologueManager.dialog_ended = false
	
