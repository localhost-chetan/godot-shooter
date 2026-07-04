class_name ItemContainer extends StaticBody2D
signal open(pos, direction) 

@onready var current_direction := Vector2.DOWN.rotated(rotation)
