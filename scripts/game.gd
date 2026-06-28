extends Node2D

@onready var level_generation = $levelgenerator
@onready var groud_sprite = $groundsprite

@onready var parallexLayer1 = $ParallaxBackground/ParallaxLayer
@onready var parallexLayer2 = $ParallaxBackground/ParallaxLayer2
@onready var parallexLayer3 = $ParallaxBackground/ParallaxLayer3
var player: Player = null

var player_scence = preload("res://scenes/player.tscn")

var game_camera = preload("res://scenes/gamecamera.tscn")

var platform_scnce = preload("res://scenes/platform.tscn")

var camera = null

var player_spwan_pos: Vector2

var viewport_size:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_size = get_viewport_rect().size
	
	var player_starting_y = 134
	player_spwan_pos.x = viewport_size.x /2.0
	player_spwan_pos.y = viewport_size.y - player_starting_y 
	
	groud_sprite.global_position.x = viewport_size.x /2.0
	groud_sprite.global_position.y = viewport_size.y -50
	
	setup_parallex_layer(parallexLayer1)
	setup_parallex_layer(parallexLayer2)
	setup_parallex_layer(parallexLayer3)
	
	new_game()

func get_parallex_sprite_scale(parallex_sprit:Sprite2D):
	var parallex_texture = parallex_sprit.get_texture()
	var parallex_texture_width = parallex_texture.get_width()
	
	var new_scale = viewport_size.x / parallex_texture_width
	var result = Vector2(new_scale, new_scale)
	return result;

func setup_parallex_layer(parallex_layer: ParallaxLayer):
	var parallex_sprite = parallex_layer.find_child("Sprite2D")
	if parallex_sprite:
		#setting scale
		parallex_layer.scale = get_parallex_sprite_scale(parallex_sprite)
		#setting mirroring 
		var my = parallex_layer.scale.y * parallex_sprite.get_texture().get_height()
		parallex_layer.motion_mirroring.y = my
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

	
