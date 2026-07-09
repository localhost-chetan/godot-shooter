extends CharacterBody2D

signal laser(player_position: Vector2, player_direction: Vector2)
signal grenade(player_position: Vector2, player_direction: Vector2)


var input_direction: Vector2
@export var move_speed := 320
var can_laser := true
var can_grenade := true

@onready var shoot_particles: GPUParticles2D = $ShootParticles
@onready var laser_spawn_positions: Node2D = $LaserSpawnPositions
@onready var laser_cooldown_timer: Timer = %LaserCooldownTimer
@onready var grenade_cooldown_timer: Timer = %GrenadeCooldownTimer


func get_random_marker_position():
	var selected_laser: Marker2D = laser_spawn_positions.get_children().pick_random()
	return selected_laser.global_position
	
	
func _physics_process(_delta: float) -> void:
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * move_speed
	self.move_and_slide()
	self.look_at(get_global_mouse_position())
	Globals.player_position = self.global_position
	

func _process(_delta: float) -> void:
	var player_direction = (self.get_global_mouse_position() - self.global_position).normalized()     
	
	if (Input.is_action_pressed("primary action") and can_laser and Globals.laser_count > 0):
		shoot_particles.emitting = true
		Globals.laser_count -= 1
		can_laser = false     
		laser_cooldown_timer.start() 
		laser.emit(get_random_marker_position(), player_direction)
		
	if (Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_count > 0):
		Globals.grenade_count -= 1
		can_grenade = false
		grenade_cooldown_timer.start()
		grenade.emit(get_random_marker_position(), player_direction)
		

func _on_laser_cooldown_timer_timeout() -> void:
	can_laser = true


func _on_grenade_cooldown_timer_timeout() -> void:
	can_grenade = true


func hit():
	Globals.player_health -= randi_range(5, 15)
