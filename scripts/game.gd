extends Node2D

@onready var level_generation = $levelgenerator
@onready var groud_sprite = $groundsprite


var player: Player = null

var player_scence = preload("res://scenes/player.tscn")

var game_camera = preload("res://scenes/gamecamera.tscn")

var platform_scnce = preload("res://scenes/platform.tscn")

var camera = null

var player_spwan_pos: Vector2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_size = get_viewport_rect().size
	
	var player_starting_y = 134
	player_spwan_pos.x = viewport_size.x /2.0
	player_spwan_pos.y = viewport_size.y - player_starting_y 
	
	groud_sprite.global_position.x = viewport_size.x /2.0
	groud_sprite.global_position.y = viewport_size.y 
	
	
	new_game()

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("rest"):
		get_tree().reload_current_scene()	
	
func new_game():
	player = player_scence.instantiate()
	player.position = player_spwan_pos
	add_child(player)
	
	camera = game_camera.instantiate()
	camera.setup_camera($player)
	add_child(camera)
	
	if player:
		level_generation.setup(player)

	
