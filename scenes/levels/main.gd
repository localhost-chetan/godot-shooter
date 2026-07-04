class_name Main extends Node


const laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
const item_scene: PackedScene = preload("res://scenes/items/item.tscn")

@onready var projectiles: Node = %Projectiles
@onready var ui: CanvasLayer = $UI
@onready var items: Node = %Items


func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_container_opened)


func _on_container_opened(pos: Vector2, direction: Vector2):
	var item := item_scene.instantiate() as Area2D
	item.position = pos
	item.direction = direction
	items.add_child.call_deferred(item)
	
   
func _on_player_laser(player_position: Vector2, player_direction: Vector2) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = player_position
	laser.direction = player_direction
	laser.rotation_degrees = rad_to_deg(player_direction.angle()) + 90
	projectiles.add_child(laser)
	ui.update_laser_text()


func _on_player_grenade(player_position: Vector2, player_direction: Vector2) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = player_position
	grenade.linear_velocity = player_direction * grenade.speed
	projectiles.add_child(grenade)
	ui.update_grenade_text()
