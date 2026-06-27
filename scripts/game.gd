extends Node2D

@onready var platfomr_parent = $platformparent

var game_camera = preload("res://scenes/gamecamera.tscn")

var platform_scnce = preload("res://scenes/platform.tscn")

var camera = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = game_camera.instantiate()
	camera.setup_camera($player)
	add_child(camera)

	# generate ground 
	var viewport_size = get_viewport_rect().size
	var platfomr_with = 134
	var ground_platform_count = (viewport_size.x / platfomr_with)
	
	var groud_layer_y_offset = 62
	print(ground_platform_count)
	for i in range(ground_platform_count):
		create_platform(Vector2(i* platfomr_with, (viewport_size.y - groud_layer_y_offset)))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("rest"):
		get_tree().reload_current_scene()	

func create_platform(location:Vector2):
	var platform = platform_scnce.instantiate()
	platform.global_position = location
	platfomr_parent.add_child(platform)
	return platform
	
