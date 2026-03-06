extends Node2D

const BULLET_SPEED: float = 900.0
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = %VisibleOnScreenNotifier2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.x * BULLET_SPEED * delta
	
	if !visible_on_screen_notifier.is_on_screen():
		queue_free()
