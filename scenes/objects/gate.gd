extends StaticBody2D

signal player_entered_gate(body: Node2D)

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_entered_gate.emit(body)
