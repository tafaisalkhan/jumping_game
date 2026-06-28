extends CharacterBody2D
class_name  Player

var speed := 300
var viewport_size
var gravity := 19
var max_gravity := 1000
var jump_velocity := -800
@onready var animator = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_size = get_viewport_rect().size

func _process(_delta: float) -> void:
	if velocity.y > 0:
		if animator.current_animation != "fall":
			animator.play("fall")
	elif velocity.y < 0:
		if animator.current_animation != "jump":
			animator.play("jump")

func _physics_process(_delta: float) -> void:
	if(velocity.y < max_gravity):
		velocity.y += gravity
	
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x,0,speed)
		
	move_and_slide()
	
	var margin := 20
	
	if global_position.x > viewport_size.x + margin:
		print("right")
		global_position.x = -margin
	if global_position.x < -margin:
		print("left")
		global_position.x = viewport_size.x
func jump():
	velocity.y = jump_velocity
