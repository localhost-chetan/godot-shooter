extends CharacterBody2D

signal laser(scout_position: Vector2, scout_direction: Vector2)


var is_player_nearby := false
var can_laser := true
@onready var laser_cooldown: Timer = %LaserCooldown
@onready var laser_spawn_positions: Node2D = %LaserSpawnPositions


func _physics_process(_delta: float) -> void:
	if (is_player_nearby and can_laser):
		self.look_at(Globals.player_position)
		
		var scout_position := (laser_spawn_positions.get_children().pick_random() as Marker2D).global_position
		var scout_direction := (Globals.player_position - self.global_position).normalized()
		laser.emit(scout_position, scout_direction)
		can_laser = false
		laser_cooldown.start()


func _on_attack_area_body_entered(_body: Node2D) -> void:
	is_player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	is_player_nearby = false


func _on_laser_cooldown_timeout() -> void:
	can_laser = true
