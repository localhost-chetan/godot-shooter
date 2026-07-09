extends CharacterBody2D


var is_active := false
var move_speed := 150
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var navigation_agent_timer: Timer = $NavigationAgentTimer


func _physics_process(_delta: float) -> void:
	if (is_active):
		self.look_at(Globals.player_position)
		var next_path_position := navigation_agent_2d.get_next_path_position()
		var direction := (next_path_position - self.global_position).normalized()
		self.velocity = (direction * move_speed)
		self.move_and_slide()


func _on_notice_area_body_entered(_body: Node2D) -> void:
	is_active = true
	navigation_agent_timer.start()


func _on_notice_area_body_exited(_body: Node2D) -> void:
	is_active = false


func _on_navigation_agent_timer_timeout() -> void:
	if (is_active):
		navigation_agent_2d.target_position = Globals.player_position
