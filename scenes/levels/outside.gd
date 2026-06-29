extends Main


func _on_gate_player_entered_gate(_body: Node2D) -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property(%Player, "speed", 0, 0.38)


func _on_house_player_entered() -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property(player_camera, "zoom", Vector2(2.25, 2.25), 0.5).set_trans(Tween.TRANS_CUBIC)


func _on_house_player_exited() -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property(player_camera, "zoom", Vector2(1.5, 1.5), 0.5).set_trans(Tween.TRANS_CUBIC)
