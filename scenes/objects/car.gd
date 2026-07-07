extends CharacterBody2D

var is_player_near := false


func _on_attack_area_body_entered(body: Node2D) -> void:
	is_player_near = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	is_player_near = false
