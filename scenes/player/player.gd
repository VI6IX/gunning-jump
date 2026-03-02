extends CharacterBody2D

@onready var fire_rate: Timer = %FireRate
@onready var marker_2d: Marker2D = $Marker2D

const GRAVITY: float = 800.0
const RECOIL: float = 500.0
var default_rotation_speed: float = 10.0
var rotation_speed: float = 0.0
var fast_spinning_speed: float = 30.0

var can_shoot: bool = true
var direction: Vector2

func _ready() -> void:
	rotation_speed = default_rotation_speed

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	update_direction()
	rotate_gun(delta)
	shoot()
	move_and_slide()
	
	if Input.is_action_just_pressed("debug_reset_position"): #RESET TO CENTER
		position = Vector2(120, 120)
		velocity = Vector2.ZERO
		rotation_speed = default_rotation_speed

func update_direction():
	direction = (global_position - marker_2d.global_position).normalized()

func apply_gravity(delta):
	velocity.y += GRAVITY * delta

func shoot():
	if can_shoot == false:
		return
	else:
		if Input.is_action_just_pressed("shoot"):
			velocity = direction * RECOIL
			rotation_speed = fast_spinning_speed
			var tween = create_tween()
			tween.tween_property(self, "rotation_speed", default_rotation_speed, 0.5)
			can_shoot = false
			fire_rate.start()

func rotate_gun(delta):
	rotation += rotation_speed * delta

func _on_fire_rate_timeout() -> void:
	can_shoot = true
