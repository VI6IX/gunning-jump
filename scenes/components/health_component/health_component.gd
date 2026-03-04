class_name HealthComponent extends Node2D

@export var parent: Node2D

@export var max_health: float
var health: float

func _ready() -> void:
	health = max_health

func deplete_health(damage):
	health -= damage
	
	if health <= 0:
		parent.queue_free()
