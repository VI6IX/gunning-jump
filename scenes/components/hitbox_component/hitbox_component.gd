class_name HitboxComponent extends Area2D

@export var parent: Node2D
@export var health_component: HealthComponent

@export var damage: float = 1

func deal_damage(damage_value):
	if !health_component:
		push_error("HealthComponent not found.")
		return
	else:
		health_component.deplete_health(damage_value)

func _on_area_entered(area: Area2D) -> void:
	if !area.has_method("deal_damage"):
		push_error("Attempting to damage an object that has no HitboxComponent")
		return
	else:
		area.deal_damage(damage)
