extends Camera2D

@onready var distroyer = $destroyer

@onready var distroyer_shape = $destroyer/CollisionShape2D

var player :Player = null

var view_port_size = null;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	view_port_size =  get_viewport_rect().size
	global_position.x = view_port_size.x / 2
	limit_bottom = view_port_size.y
	limit_left=0
	limit_right= view_port_size.x
	
	distroyer.position.y = view_port_size.y 
	
	var rect_shape = RectangleShape2D.new()
	var rect_shape_size = Vector2(view_port_size.x , 100)
	rect_shape.set_size(rect_shape_size)
	distroyer_shape.shape = rect_shape


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player:
		var limit_distance = 500
		if limit_bottom > player.global_position.y + limit_distance:
			limit_bottom = int(player.global_position.y + limit_distance)
			
	var overlapping_areas = distroyer.get_overlapping_areas()
	if overlapping_areas.size() > 0:
		for area in overlapping_areas:
			if area is platform:
				area.queue_free()
	
func setup_camera(_player: Player):
	if _player:
		player = _player
		
func _physics_process(_delta: float) -> void:
	if player:
		global_position.y = player.global_position.y
