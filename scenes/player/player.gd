extends CharacterBody2D

signal laser(pos: Vector2)
signal grenade(pos: Vector2)
   

var direction: Vector2
var speed := 300
var can_laser := true
var can_grenade := true

@onready var laser_timer: Timer = %LaserTimer
@onready var grenade_reload_timer: Timer = %GrenadeReloadTimer
@onready var laser_start_positions: Node = $LaserStartPositions


func _ready():
	print(self.velocity)


func get_random_marker_position():
	var selected_laser: Marker2D = laser_start_positions.get_children().pick_random()
	return selected_laser.global_position
	


func _process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	self.move_and_slide()
	
	if (Input.is_action_pressed("primary action") and can_laser):
		can_laser = false 
		laser_timer.start() 
		laser.emit(get_random_marker_position())
		
	if (Input.is_action_pressed("secondary action") and can_grenade):
		can_grenade = false
		grenade_reload_timer.start()
		grenade.emit(get_random_marker_position())


func _on_laser_timer_timeout() -> void:
	can_laser = true


func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true
