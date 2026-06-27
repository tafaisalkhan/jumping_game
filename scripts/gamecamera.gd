extends Camera2D

var player :Player = null

var view_port_size = null;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	view_port_size =  get_viewport_rect().size
	global_position.x = view_port_size.x / 2
	limit_bottom = view_port_size.y
	limit_left=0
	limit_right= view_port_size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		var limit_distance = 500
		if limit_bottom > player.global_position.y + limit_distance:
			limit_bottom = player.global_position.y + limit_distance
	
func setup_camera(_player: Player):
	if _player:
		player = _player
		
func _physics_process(delta: float) -> void:
	if player:
		global_position.y = player.global_position.y
