extends Node


const laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

@onready var projectiles: Node = %Projectiles


func _on_gate_player_entered_gate(body: Node2D) -> void:
	print(body, " has entered")


func _on_player_laser(pos: Vector2) -> void:
	var laser = laser_scene.instantiate()
	laser.position = pos
	projectiles.add_child(laser)


func _on_player_grenade(pos: Vector2) -> void:
	var grenade = grenade_scene.instantiate()
	grenade.position = pos
	projectiles.add_child(grenade)
