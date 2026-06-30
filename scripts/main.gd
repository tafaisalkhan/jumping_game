extends Node

@onready var game = $game
@onready var screen = $screens

var game_in_progress = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	screen.start_game.connect(_on_screen_start_game)
	screen.delete_level.connect(_on_delete_level)
	game.game_over_signal.connect(_on_screen_game_over)
	game.pause_signal.connect(_on_pause_btn)
	DisplayServer.window_set_window_event_callback(_on_window_event)

func _on_window_event(event):
	#print("window" + str(event))
	match event:
		DisplayServer.WINDOW_EVENT_FOCUS_IN:
			pass
		DisplayServer.WINDOW_EVENT_FOCUS_OUT:
			#print("window out focus")
			_on_pause_btn()
		DisplayServer.WINDOW_EVENT_CLOSE_REQUEST:
			get_tree().quit()
#	
	
func _on_pause_btn():
	game_in_progress = true
	get_tree().paused = true
	screen.show_pause_screen()
	
func _on_screen_start_game():
	game_in_progress=true
	game.new_game()

func _on_delete_level():
	game_in_progress=false
	game.game_reset()	

func _on_screen_game_over(_score, _highscore):
	game_in_progress = false
	await (get_tree().create_timer(0.75).timeout)
	screen.game_over_screen(_score, _highscore)
