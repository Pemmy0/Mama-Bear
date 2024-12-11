extends Area2D

@onready var pointer = %Pointer
@onready var audio_stream_player = $AudioStreamPlayer

@export var door_open: AudioStream
@export var door_close: AudioStream

var player
var lines = ObjectLibrary.living_room_parents_1

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if !GlobalPosition.to_living_from_parents:
		load_sfx(door_close)
		audio_stream_player.pitch_scale += randf_range(-0.2, 0.2)
		audio_stream_player.play()
		player.animated_sprite_2d.flip_h = true
		player.position.x = GlobalPosition.parents_door_position.x
		GlobalPosition.to_living_from_parents = true
	pointer.hide()

func _process(delta):
	if !ObjectLibrary.bathroom_has_entered && ObjectLibrary.kitchen_has_entered:
		lines = ObjectLibrary.living_room_parents_2

func load_sfx(sfx_to_load):
	if audio_stream_player.stream != sfx_to_load:
		audio_stream_player.stop()
		audio_stream_player.stream = sfx_to_load

func _on_body_entered(_body):
	pointer.show()
	pointer.play("pointer")

func _on_body_exited(_body):
	pointer.hide()
	MonologueManager.dialog_ended = false
	
func scene_transition():
	load_sfx(door_open)
	audio_stream_player.pitch_scale += randf_range(-0.2, 0.2)
	audio_stream_player.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Main Scenes/scene_3_parents_room.tscn")
