extends RigidBody2D


@export var speed : int
 

func explode():
	$AnimationPlayer.play("Explosion")
