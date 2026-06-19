extends Area2D


@export var speed := 1500
var direction : Vector2

func _process(delta: float) -> void:
	self.position += (direction * speed) * delta
	 
