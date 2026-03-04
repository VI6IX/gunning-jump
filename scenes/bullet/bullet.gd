extends Node2D

const BULLET_SPEED: float = 900.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.x * BULLET_SPEED * delta
