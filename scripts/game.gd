extends Node2D

@onready var level_generation = $levelgenerator
@onready var groud_sprite = $groundsprite

@onready var parallexLayer1 = $ParallaxBackground/ParallaxLayer
@onready var parallexLayer2 = $ParallaxBackground/ParallaxLayer2
@onready var parallexLayer3 = $ParallaxBackground/ParallaxLayer3
@onready var hud = $UIlayer/HUD
signal game_over_signal(score, hightscore)

signal pause_signal

var score : int =0
var high_score:int =0

var player: Player = null

var player_scence = preload("res://scenes/player.tscn")

var game_camera = preload("res://scenes/gamecamera.tscn")

var platform_scnce = preload("res://scenes/platform.tscn")

var camera = null

var player_spwan_pos: Vector2

var viewport_size:Vector2

var save_file_paht = "user://highscore.save"

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
	
	hud.visible = false
	groud_sprite.visible = false
	
	hud.pause_signal.connect(_on_pause_game)
	
	load_score()
	#new_game()

func _on_pause_game():
	pause_signal.emit()

func get_parallex_sprite_scale(parallex_sprit:Sprite2D):
	var parallex_texture = parallex_sprit.get_texture()
	var parallex_texture_width = parallex_texture.get_width()
	
	var new_scale = viewport_size.x / parallex_texture_width
	var result = Vector2(new_scale, new_scale)
	return result;

func setup_parallex_layer(parallex_layer: ParallaxLayer):
	var parallex_sprite = parallex_layer.find_child("Sprite2D")
	if parallex_sprite != null:
#		#setting scale
		parallex_sprite.scale = get_parallex_sprite_scale(parallex_sprite)
		#setting mirroring 
		var my = parallex_layer.scale.y * parallex_sprite.get_texture().get_height()
		parallex_layer.motion_mirroring.y = my

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("rest"):
		get_tree().reload_current_scene()
	if player != null:
		if score <	(viewport_size.y - player.global_position.y):
			score = int((viewport_size.y - player.global_position.y))
			hud.set_hud_score(score)	
	
func new_game():
	score = 0
	hud.set_hud_score(0)
	game_reset()
	await (get_tree().create_timer(.5).timeout)
	
	player = player_scence.instantiate()
	player.position = player_spwan_pos
	player.died.connect(_on_player_died)
	add_child(player)
	
	camera = game_camera.instantiate()
	camera.setup_camera($player)
	add_child(camera)
	
	hud.visible = true
	groud_sprite.visible = true
	
	if player:
		level_generation.start_generation()
		level_generation.setup(player)

func _on_player_died():
	
	hud.visible = false
	if score > high_score:
		high_score = score
		save_score(high_score)
	game_over_signal.emit(score, high_score)
	
func game_reset():
	hud.visible = false
	groud_sprite.visible = false
	level_generation.rest_level()
	if player != null:
		player.queue_free()
		player =  null
		level_generation.player = null
	if camera != null:
		camera.queue_free()
		camera = null

func save_score(high_sroce):
	var file = FileAccess.open(save_file_paht,FileAccess.WRITE)
	file.store_var(high_score)
	file.close()
	
func load_score():
	if(FileAccess.file_exists(save_file_paht)):
		print("laod form file")
		var file = FileAccess.open(save_file_paht,FileAccess.READ)
		high_score = file.get_var(high_score)
		file.close()
	else:
		high_score = 0
