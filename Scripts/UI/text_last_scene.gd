extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var letter_display_timer = $LetterDisplayTimer
@onready var audio_player = $AudioStreamPlayer

var text = ""
var letter_index = 0

const MAX_WIDTH = 258

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String, speech_sfx: AudioStream):
	text = text_to_display
	label.text = text_to_display
	audio_player.stream = speech_sfx
	
	await resized
	label.custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	
	label.text = ""
	global_position.x -= size.x / 2
	
	pivot_offset = Vector2(size.x / 2, size.y)
	
	_display_letter()
	
func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
		
	match text[letter_index]:
		"!", ".", ",", "?":
			letter_display_timer.start(punctuation_time)
		" ":
			letter_display_timer.start(space_time)
		_:
			letter_display_timer.start(letter_time+0.02)
			
			var new_audio_player = audio_player.duplicate()
			new_audio_player.pitch_scale += randf_range(-0.1, 0.1)
			new_audio_player.pitch_scale += 0.1
			if text[letter_index] in ["a", "e", "i", "o", "u"]:
				new_audio_player.pitch_scale += 0.2
			get_tree().root.add_child(new_audio_player)
			new_audio_player.play()
			await new_audio_player.finished
			new_audio_player.queue_free()

func _on_letter_display_timer_timeout():
	_display_letter()
