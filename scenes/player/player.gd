extends CharacterBody2D

signal laser(player_position: Vector2, player_direction: Vector2)
signal grenade(player_position: Vector2, player_direction: Vector2)
signal update_stats()

var direction: Vector2
@export var speed := 250
var can_laser := true
var can_grenade := true

@onready var laser_timer: Timer = %LaserTimer
@onready var grenade_reload_timer: Timer = %GrenadeReloadTimer
@onready var laser_start_positions: Node = $LaserStartPositions
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


func get_random_marker_position():
	var selected_laser: Marker2D = laser_start_positions.get_children().pick_random()
	return selected_laser.global_position
	
	
func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	self.move_and_slide()
	self.look_at(get_global_mouse_position())
	

func _process(_delta: float) -> void:
	var player_direction = (self.get_global_mouse_position() - self.global_position).normalized()     
	
	if (Input.is_action_pressed("primary action") and can_laser and Globals.laser_count > 0):
		Globals.laser_count -= 1
		gpu_particles_2d.emitting = true
		can_laser = false     
		laser_timer.start() 
		laser.emit(get_random_marker_position(), player_direction)
		
	if (Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_count > 0):
		Globals.grenade_count -= 1
		can_grenade = false
		grenade_reload_timer.start()
		grenade.emit(get_random_marker_position(), player_direction)
		

func _on_laser_timer_timeout() -> void:
	can_laser = true


func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true

	
func add_item(type: Global.ItemType) -> void:
	const ItemType := Global.ItemType

	if (type == ItemType.laser):
		Globals.laser_count += 5
	elif (type == ItemType.grenade):
		Globals.grenade_count += 1
	update_stats.emit()		
