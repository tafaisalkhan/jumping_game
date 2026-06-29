extends CanvasLayer

@onready var console = $debug/consoleLogs

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("sdfsdf")
	console.visible = false # Replace with function body.
	print("in ready")
	register_button()

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
	print(button.name)
	match button.name:
		"play":
			print("play button")
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
	print("sdfds")
	console.visible = !console.visible # Replace with function body.
