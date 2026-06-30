extends Main


func change_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/outside.tscn")


func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property(%Player, "speed", 0, 0.3)
	change_scene.call_deferred()
