extends Node2D

var platform_scnce = preload("res://scenes/platform.tscn")
@onready var platfomr_parent = $platformparent

var y_distance_between_platfomr = 100
var start_platform_y
var level_size = 15
var platfomr_with = 134
var viewport_size
var platform_generated_count

var player : Player = null

func setup(_player:Player):
	if _player:
		player = _player

func _ready() -> void:
	viewport_size = get_viewport_rect().size

	# generate ground 
	generate_ground()
	#generate level
	platform_generated_count = 0
	start_platform_y = viewport_size.y - (y_distance_between_platfomr * 2 )
	generate_level(start_platform_y)
	
func _process(delta: float) -> void:
	if player:
		var py = player.global_position.y
		var end_level_pos = start_platform_y - (platform_generated_count * y_distance_between_platfomr)
		var threshold = end_level_pos + (y_distance_between_platfomr * 6)
		if (py <= threshold):
			generate_level(end_level_pos)
func generate_ground():	
	var ground_platform_count = (viewport_size.x / platfomr_with)
	
	var groud_layer_y_offset = 62
	print(ground_platform_count)
	for i in range(ground_platform_count):
		create_platform(Vector2(i* platfomr_with, (viewport_size.y - groud_layer_y_offset)))
	
func generate_level(start_y:float):
	for i in range(level_size):
		var max_x_position = viewport_size.x - platfomr_with
		var random_x = randf_range(0.0, max_x_position)
		var location: Vector2
		location.x = random_x
		location.y = start_y - (y_distance_between_platfomr * i) 
		create_platform(location)
		platform_generated_count += 1
	print(platform_generated_count)

func create_platform(location:Vector2):
	var platform = platform_scnce.instantiate()
	platform.global_position = location
	platfomr_parent.add_child(platform)
	return platform
