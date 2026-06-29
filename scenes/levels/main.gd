extends Node


const laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

@onready var projectiles: Node = %Projectiles


func _on_gate_player_entered_gate(_body: Node2D) -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property(%Player, "speed", 0, 0.38)
	

func _on_player_laser(player_position: Vector2, player_direction: Vector2) -> void:
	var laser = laser_scene.instantiate() as StaticBody2D
	laser.position = player_position
	laser.direction = player_direction
	laser.rotation_degrees = rad_to_deg( player_direction.angle()) + 90 
	projectiles.add_child(laser)


func _on_player_grenade(player_position: Vector2, player_direction: Vector2) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = player_position
	grenade.linear_velocity = player_direction * grenade.speed
	projectiles.add_child(grenade)


func _on_house_player_entered() -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(2.25, 2.25), 0.5).set_trans(Tween.TRANS_CUBIC)
	


func _on_house_player_exited() -> void:
	var tween = self.get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1.5, 1.5), 0.5).set_trans(Tween.TRANS_CUBIC)
