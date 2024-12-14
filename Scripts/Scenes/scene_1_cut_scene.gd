extends Node2D

@onready var cutscene = $Cutscene

var stop_loop = false

func _ready():
	cutscene.play("Default")
	GlobalPosition.current_room = "bedroom"
	RoomAmbience.play_room_ambience()
	ObjectLibrary.has_played_ambience = true
	
func _unhandled_input(event):
	if Input.is_anything_pressed():
		stop_loop = true
		
func _on_cutscene_animation_finished():
	if cutscene.animation == "Default":
		if !stop_loop: cutscene.play("Default")
		else: 
			get_tree().change_scene_to_file("res://Scenes/Cutscenes/scene_1_2_cut_scene.tscn")
