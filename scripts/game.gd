extends Node2D

@onready var platfomr_parent = $platformparent

var game_camera = preload("res://scenes/gamecamera.tscn")

var platform_scnce = preload("res://scenes/platform.tscn")

var camera = null

var y_distance_between_platfomr = 100
var start_platform_y
var level_size = 50
var platfomr_with = 134
var viewport_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = game_camera.instantiate()
	camera.setup_camera($player)
	add_child(camera)
	viewport_size = get_viewport_rect().size

	# generate ground 
	generate_ground()
	#generate level
	generate_level()
	
	
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
	

func generate_ground():	
	var ground_platform_count = (viewport_size.x / platfomr_with)
	
	var groud_layer_y_offset = 62
	print(ground_platform_count)
	for i in range(ground_platform_count):
		create_platform(Vector2(i* platfomr_with, (viewport_size.y - groud_layer_y_offset)))
	
func generate_level():
	var start_platform_y = viewport_size.y - (y_distance_between_platfomr * 2 )
	for i in range(level_size):
		var max_x_position = viewport_size.x - platfomr_with
		var random_x = randf_range(0.0, max_x_position)
		var location: Vector2
		location.x = random_x
		location.y = start_platform_y - (y_distance_between_platfomr * i) 
		create_platform(location)
