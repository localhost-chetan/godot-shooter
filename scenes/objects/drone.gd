extends CharacterBody2D


var direction_to_player : Vector2
var current_speed := 0
var movement_allowed := 1
const MAX_MOVE_SPEED := 200
var is_chasing := false
var is_vulnerable := true
var health := 50
var is_exploding := false
var explosion_range := 200
@onready var hit_timer: Timer = %HitTimer


func _physics_process(delta: float) -> void:
	if (is_chasing and movement_allowed):
		var player_position := Globals.player_position
		
		if(not is_exploding):
			self.look_at(player_position)
			
		direction_to_player = (player_position - self.global_position).normalized()
		self.velocity = (direction_to_player * current_speed) * movement_allowed
		var collisionObject := self.move_and_collide(velocity * delta)
		
		if (collisionObject):
			$AnimationPlayer.play("explosion")
			
	if (is_exploding):
		var targets := get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		
		for target in targets:
			var is_in_range = target.global_position.distance_to(self.global_position) < explosion_range
			
			if(("hit" in target) and is_in_range):
				target.hit()


func on_explosion_stop_movement():
	movement_allowed = 0
	is_exploding = true


func hit():
	if (is_vulnerable):
		is_vulnerable = false
		health -= randi_range(5, 10)
		hit_timer.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
		
		if (health <= 0):
			$AnimationPlayer.play("explosion")


func _on_notice_area_body_entered(_body: Node2D) -> void:
	is_chasing = true
	var tween := get_tree().create_tween()
	tween.tween_property(self, "current_speed", MAX_MOVE_SPEED, 4).set_trans(Tween.TRANS_CUBIC)


func _on_notice_area_body_exited(_body: Node2D) -> void:
	is_chasing = false


func _on_hit_timer_timeout() -> void:
	is_vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
