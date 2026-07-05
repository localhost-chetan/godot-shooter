extends CharacterBody2D

signal laser(scout_position: Vector2, scout_direction: Vector2)


var health := 30

var is_player_nearby := false
var can_laser := true
var is_vulnerable := true
@export var speed : int
@onready var laser_cooldown: Timer = %LaserCooldown
@onready var laser_spawn_positions: Node2D = %LaserSpawnPositions
@onready var hit_timer: Timer = %HitTimer
@onready var sprite_2d: Sprite2D = $Sprite2D


func _physics_process(_delta: float) -> void:
	if (not is_player_nearby):
		return
		
	var scout_direction := (Globals.player_position - self.global_position).normalized()
	self.velocity = scout_direction * speed
	self.move_and_slide()
		
	if (can_laser):
		self.look_at(Globals.player_position)
		var scout_position := (laser_spawn_positions.get_children().pick_random() as Marker2D).global_position
		
		laser.emit(scout_position, scout_direction)
		can_laser = false
		laser_cooldown.start()


func _on_attack_area_body_entered(_body: Node2D) -> void:
	is_player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	is_player_nearby = false


func _on_laser_cooldown_timeout() -> void:
	can_laser = true
	

func hit():
	if (is_vulnerable):
		health -= randi_range(2, 7)
		is_vulnerable = false
		hit_timer.start()
		sprite_2d.material.set_shader_parameter("progress", 1)
		
	if (health <= 0):
		self.queue_free()


func _on_hit_timer_timeout() -> void:
	is_vulnerable = true
	sprite_2d.material.set_shader_parameter("progress", 0)
