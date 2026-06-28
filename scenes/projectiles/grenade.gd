extends RigidBody2D


@export var speed :=  750
 

func explode():
	$AnimationPlayer.play("Explosion")
