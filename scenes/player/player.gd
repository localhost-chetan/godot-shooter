extends CharacterBody2D


var direction: Vector2
var speed := 400

var can_laser := true
var can_grenade := true

@onready var laser_timer: Timer = %LaserTimer
@onready var grenade_reload_timer: Timer = %GrenadeReloadTimer


func _ready():
	print(self.velocity)


func _process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	self.move_and_slide()
	
	if (Input.is_action_pressed("primary action") and can_laser):
		print("Laser")
		can_laser = false 
		laser_timer.start()
		
	if (Input.is_action_pressed("secondary action") and can_grenade):
		print("Grenade")
		can_laser = false
		grenade_reload_timer.start()
		


func _on_laser_timer_timeout() -> void:
	can_laser = true


func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true
