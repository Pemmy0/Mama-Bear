extends Area2D

@onready var pointer = %Pointer
@onready var audio_stream_player = $AudioStreamPlayer

var player

@export var door_open: AudioStream
@export var door_close: AudioStream

func _ready():
	player = get_tree().get_first_node_in_group("player")
	load_sfx(door_close)
	audio_stream_player.pitch_scale += randf_range(-0.2, 0.2)
	if GlobalPosition.to_livingroom:
		audio_stream_player.play()
	GlobalPosition.to_corridor = false
	pointer.hide()
	
func load_sfx(sfx_to_load):
	if audio_stream_player.stream != sfx_to_load:
		audio_stream_player.stop()
		audio_stream_player.stream = sfx_to_load

func _on_body_entered(_body):
	pointer.show()
	pointer.play("pointer")

func _on_body_exited(_body):
	pointer.hide()
	
func scene_transition():
	load_sfx(door_open)
	audio_stream_player.pitch_scale += randf_range(-0.2, 0.2)
	audio_stream_player.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_1_bedroom.tscn")
