extends CharacterBody2D

@onready var fire_rate: Timer = %FireRate

const GRAVITY: float = 800.0
const RECOIL: float = 300.0
var default_rotation_speed: float = 10.0
var rotation_speed: float = 0.0
var rotation_target: float = 50.0

var can_shoot: bool = true
var is_fast_spinning: bool = false

func _ready() -> void:
	rotation_speed = default_rotation_speed

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	rotate_gun(delta)
	move_and_slide()

func apply_gravity(delta):
	velocity.y += GRAVITY * delta

func shoot():
	if Input.is_action_just_pressed("shoot"):
		pass

func interpolate_rotation_speed():
	pass

func rotate_gun(delta):
	rotation += rotation_speed * delta
	if Input.is_action_just_pressed("shoot"):
		rotation_speed = rotation_target
