extends CharacterBody2D


var speed : int = 100
var is_chasing := false
var is_in_attack_range := false
var direction_to_player : Vector2
var is_vulnerable := true
var health := 100
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_timer: Timer = %HitTimer
@onready var attack_timer: Timer = %AttackTimer


func _physics_process(_delta: float) -> void:
	if (not is_chasing):
		return
	
	direction_to_player = (Globals.player_position - self.global_position).normalized()
	self.velocity = direction_to_player * speed
	self.move_and_slide()
	self.look_at(Globals.player_position)
	
	
func hit():
	if (is_vulnerable):
		health -= randi_range(2, 7)
		is_vulnerable = false
		hit_timer.start()
		animated_sprite_2d.material.set_shader_parameter("progress", 1)

		if (health <= 0):
			self.queue_free()
	

func _on_attack_area_2d_body_entered(_body: Node2D) -> void:
	is_in_attack_range = true
	animated_sprite_2d.play("attack")


func _on_attack_area_2d_body_exited(_body: Node2D) -> void:
	is_in_attack_range = false
	animated_sprite_2d.stop()


func _on_notice_area_2d_body_entered(_body: Node2D) -> void:
	is_chasing = true
	animated_sprite_2d.play("walk")


func _on_notice_area_2d_body_exited(_body: Node2D) -> void:
	is_chasing = false
	animated_sprite_2d.stop()


func _on_animated_sprite_2d_animation_finished() -> void:
	if (is_in_attack_range):
		Globals.player_health -= randi_range(2, 7)
		attack_timer.start()


func _on_hit_timer_timeout() -> void:
	is_vulnerable = true
	animated_sprite_2d.material.set_shader_parameter("progress", 0)


func _on_attack_timer_timeout() -> void:
	animated_sprite_2d.play("attack")
