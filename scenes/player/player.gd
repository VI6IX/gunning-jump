extends CharacterBody2D

@onready var fire_rate: Timer = %FireRate
@onready var marker_2d: Marker2D = $Marker2D
@export var bullet: PackedScene
@export var muzzle_flash: CPUParticles2D
@export var smoke: CPUParticles2D

const GRAVITY: float = 800.0
const RECOIL: float = 500.0
var default_rotation_speed: float = 10.0
var rotation_speed: float = 0.0
var fast_spinning_speed: float = 30.0

var can_shoot: bool = true
var direction: Vector2

signal has_died

func _ready() -> void:
	rotation_speed = default_rotation_speed

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	update_direction()
	rotate_gun(delta)
	shoot()
	move_and_slide()
	
	if Input.is_action_just_pressed("debug_reset_position"): #RESET TO CENTER
		position = Vector2(175, 120)
		velocity = Vector2.ZERO
		rotation_speed = default_rotation_speed

func update_direction() -> void:
	direction = (global_position - marker_2d.global_position).normalized()

func apply_gravity(delta) -> void:
	velocity.y += GRAVITY * delta

func rotate_gun(delta) -> void:
	rotation += rotation_speed * delta

func instantiate_bullet() -> void:
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = marker_2d.global_position
	bullet_instance.global_rotation = marker_2d.global_rotation
	bullet_instance.set_as_top_level(true)
	get_parent().add_child(bullet_instance)
	# Adds an instance of bullet to the Scene the Player is in

func shoot() -> void:
	if can_shoot == false:
		return
	else:
		if Input.is_action_just_pressed("shoot"):
			velocity = direction * RECOIL
			if rotation_speed > 0:
				rotation_speed = fast_spinning_speed * -1
			elif rotation_speed < 0:
				rotation_speed = fast_spinning_speed
			
			instantiate_bullet()
			muzzle_flash.set_emitting(true)
			smoke.set_emitting(true)
			tween_rotation_speed()
			can_shoot = false
			fire_rate.start()

func tween_rotation_speed():
	var tween = create_tween()
	if rotation_speed > 0:
		tween.tween_property(self, "rotation_speed", default_rotation_speed, 0.5)
	elif rotation_speed < 0:
		tween.tween_property(self, "rotation_speed", default_rotation_speed * -1, 0.5)
 
func _on_fire_rate_timeout() -> void:
	can_shoot = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(1) or area.get_collision_layer_value(5):
		velocity.x = velocity.x * -1
		rotation_speed = -rotation_speed
	elif area.get_collision_layer_value(4) or area.get_collision_layer_value(6):
		has_died.emit()
		print("Player has_died signal emitted.")
