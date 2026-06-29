class_name Main extends Node


const laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

@onready var projectiles: Node = %Projectiles
@onready var player_camera: Camera2D = %PlayerCamera


func _on_player_laser(player_position: Vector2, player_direction: Vector2) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = player_position
	laser.direction = player_direction
	laser.rotation_degrees = rad_to_deg(player_direction.angle()) + 90
	projectiles.add_child(laser)


func _on_player_grenade(player_position: Vector2, player_direction: Vector2) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = player_position
	grenade.linear_velocity = player_direction * grenade.speed
	projectiles.add_child(grenade)
