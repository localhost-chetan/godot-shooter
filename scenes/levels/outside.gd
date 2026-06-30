extends Main

@onready var player_camera: Camera2D = %PlayerCamera


func change_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")


func _on_gate_player_entered_gate(_body: Node2D) -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property(%Player, "speed", 0, 0.38)
	change_scene.call_deferred()


func _on_house_player_entered() -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property(player_camera, "zoom", Vector2(2.25, 2.25), 0.5).set_trans(Tween.TRANS_CUBIC)


func _on_house_player_exited() -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property(player_camera, "zoom", Vector2(1.5, 1.5), 0.5).set_trans(Tween.TRANS_CUBIC)
