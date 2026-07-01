extends Area2D


@export var speed := 1500
var direction : Vector2


func _ready():
	%LaserTimeout.start()
	

func _process(delta: float) -> void:
	self.position += (direction * speed) * delta
	 

func _on_body_entered(body: Node2D) -> void:
	if ("hit" in body):
		body.hit() 
	self.queue_free()


func _on_laser_timeout_timeout() -> void:
	self.queue_free()
