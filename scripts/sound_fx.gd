extends Node2D

var sounds = {
	"click" :load("res://assets/sound/Click.wav"),
	"fall" :load("res://assets/sound/Fall.wav"),
	"jump":load("res://assets/sound/Jump.wav")
}
@onready var sound_players = get_children()

func play(sound_name):
	var sound_to_play = sounds[sound_name]
	for sound_player in sound_players:
		if !sound_player.playing:
			sound_player.stream = sound_to_play
			sound_player.play()
			return
	print("too namy sound playing at once, not enough sound players ")	
	
