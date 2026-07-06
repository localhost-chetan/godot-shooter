extends RigidBody2D


@export var speed : int
@export var explosion_radius : int

var is_explosion_active := false


func explode():
	$AnimationPlayer.play("Explosion")
	is_explosion_active = true


func _physics_process(_delta: float) -> void:
	if (is_explosion_active):
		var targets := get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = (target.global_position.distance_to(self.global_position)) < explosion_radius
			if ("hit" in target and in_range):
				target.hit()
