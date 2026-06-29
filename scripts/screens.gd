extends CanvasLayer

@onready var console = $debug/consoleLogs

@onready var title_screen = $titlescreen
@onready var pause_screen = $pausescreen
@onready var gameover_screen = $gameoverscreen

var current_screen = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	console.visible = false # Replace with function body.
	register_button()
	change_screen(title_screen)

func register_button():
	print ("register buuton")
	var buttons = get_tree().get_nodes_in_group("buttons")
	print("Dfd")
	print (buttons)
	if buttons.size() > 0:
		print(buttons)
		for button in buttons:
			if button is ScreenButton:
				button.clicked.connect(_on_buuton_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_buuton_pressed(button):
	match button.name:
		"play":
			change_screen(pause_screen)
		"pauseBackBtn":
			print("pause back button")
		"pauseRetryBtn":
			print("pause retry button")
		"pauseCloseBtn":
			print("pause close button")
		"gameMenuBtn":
			print("game main menu button")
		"gameRetryBtn":
			print("game retry butotn")
		
		
	MyUtility.add_log_msg(button.name)

func _on_toggle_console_pressed() -> void:
	console.visible = !console.visible # Replace with function body.
	
func change_screen(new_screen):
	if current_screen != null:
		current_screen.disappear()
	current_screen = new_screen
	if current_screen != null:
		current_screen.appear()
