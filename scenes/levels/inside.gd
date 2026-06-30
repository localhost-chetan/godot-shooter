extends Main


func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property(%Player, "speed", 0, 0.38)
