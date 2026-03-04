class_name HitboxComponent extends Area2D

@export var parent: Node2D
@export var HealthComponent: Node2D

func _ready() -> void:
	if !parent:
		push_error("This HitboxComponent has no parent assigned.")
		return
	else:
		print(str(parent.name))

func deal_damage(damage):
	if !HealthComponent:
		push_error("HealthComponent not found.")
		return
	else:
		pass
