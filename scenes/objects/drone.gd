extends StaticBody2D

var direction := Vector2.RIGHT
var velocity : Vector2


func _physics_process(delta: float) -> void:
	velocity = direction * 200 * delta
	self.position += velocity


func hit():
	print("Damage")
