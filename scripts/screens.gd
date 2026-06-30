extends CanvasLayer

signal start_game
signal delete_level

@onready var console = $debug/consoleLogs

@onready var title_screen = $titlescreen
@onready var pause_screen = $pausescreen
@onready var gameover_screen = $gameoverscreen
@onready var gameover_score_label = $gameoverscreen/TextureRect/score
@onready var gameover_best_score_label = $gameoverscreen/TextureRect/best

var current_screen = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	console.visible = false # Replace with function body.
	register_button()
	change_screen(title_screen)

func register_button():
	var buttons = get_tree().get_nodes_in_group("buttons")
	if buttons.size() > 0:
		print(buttons)
		for button in buttons:
			if button is ScreenButton:
				button.clicked.connect(_on_buuton_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_buuton_pressed(button):
	SoundFx.play("click")
	match button.name:
		"play":
			change_screen(null)
			await (get_tree().create_timer(0.5).timeout)
			start_game.emit()
			#change_screen(pause_screen)
		"pauseBackBtn":
			change_screen(null)
			await (get_tree().create_timer(0.75).timeout)
			get_tree().paused = false
			start_game.emit()
		"pauseRetryBtn":
			change_screen(title_screen)
			get_tree().paused = false
			delete_level.emit()
		"pauseCloseBtn":
			change_screen(null)
			await (get_tree().create_timer(0.75).timeout)
			get_tree().paused = false
		"gameMenuBtn":
			change_screen(title_screen)
			delete_level.emit()
		"gameRetryBtn":
			change_screen(null)
			await (get_tree().create_timer(0.5).timeout)
			start_game.emit()
		
		
	MyUtility.add_log_msg(button.name)

func _on_toggle_console_pressed() -> void:
	console.visible = !console.visible # Replace with function body.
	
func change_screen(new_screen):
	if current_screen != null:
		var disappear_tween = current_screen.disappear()
		await (disappear_tween.finished)
		current_screen.visible = false
	current_screen = new_screen
	if current_screen != null:
		var current_tween = current_screen.appear()
		await (current_tween.finished)
		get_tree().call_group("buttons","set_disabled", false)

func game_over_screen(_score, _scorehigh):
	gameover_score_label.text = "Score: " +  str(_score)
	gameover_best_score_label.text = "Best: " + str(_scorehigh)
	change_screen(gameover_screen)		
	
func show_pause_screen():
	change_screen(pause_screen)
	
