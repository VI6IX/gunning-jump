@tool
extends Camera2D

@export var player: CharacterBody2D
@onready var position_refresh_rate: Timer = $PositionRefreshRate

func _on_position_refresh_rate_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "global_position", player.global_position, 0.5)
