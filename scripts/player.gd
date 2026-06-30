extends CharacterBody2D
class_name  Player

var speed := 300
var viewport_size
var gravity := 19
var max_gravity := 1000
var jump_velocity := -800
@onready var animator = $AnimationPlayer
@onready var cshape = $CollisionShape2D

signal died

var accelero_speed = 134.0

var use_accelerometer = false

var dead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_size = get_viewport_rect().size

	var os_name = OS.get_name()
	if os_name == "Android" || os_name == "iOS":
		use_accelerometer = true
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
	
	if !dead:
		if use_accelerometer:
			var mobile_input = Input.get_accelerometer()
			velocity.x = mobile_input.x * accelero_speed
		else:
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
	SoundFx.play("jump")
	velocity.y = jump_velocity


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die() # Replace with function body.

func die():
	if !dead:
		dead = true
		died.emit()
		cshape.set_deferred("disabled",true)
		SoundFx.play("fall")
