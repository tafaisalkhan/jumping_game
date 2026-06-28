extends Node2D

@onready var level_generation = $levelgenerator

@onready var player = $player

var game_camera = preload("res://scenes/gamecamera.tscn")

var platform_scnce = preload("res://scenes/platform.tscn")

var camera = null



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = game_camera.instantiate()
	camera.setup_camera($player)
	add_child(camera)
	
	if player:
		level_generation.setup(player)

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("rest"):
		get_tree().reload_current_scene()	
	


	
