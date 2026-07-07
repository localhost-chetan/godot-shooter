extends PathFollow2D


var is_player_near := false
var target_position : Vector2
@onready var turret: Node2D = %Turret
@onready var laser_1: RayCast2D = %Laser1
@onready var laser_2: RayCast2D = %Laser2
@onready var laser_line_1: Line2D = %LaserLine1
@onready var laser_line_2: Line2D = %LaserLine2
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var gun_fire_1: Sprite2D = %GunFire1
@onready var gun_fire_2: Sprite2D = %GunFire2


func _ready():
	laser_line_1.add_point(laser_1.target_position)
	laser_line_2.add_point(laser_2.target_position)


func fire():
	Globals.player_health -= randi_range(10, 20)
	gun_fire_1.modulate.a = 1
	gun_fire_2.modulate.a = 1
	
	var tween := get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun_fire_1, "modulate:a", 0, randf_range(0.2, 0.55))
	tween.tween_property(gun_fire_2, "modulate:a", 0, randf_range(0.2, 0.55))


func _physics_process(delta: float) -> void:
	self.progress_ratio += 0.02  * delta
	
	if (is_player_near):
		turret.look_at(Globals.player_position)


func _on_attack_area_body_entered(_body: Node2D) -> void:
	is_player_near = true
	animation_player.play("laser_load")
	

func _on_attack_area_body_exited(_body: Node2D) -> void:
	is_player_near = false
	animation_player.pause()
	
	var tween := get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(laser_line_1, "width", 0, randf_range(0.2, 0.5)).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(laser_line_2, "width", 0, randf_range(0.2, 0.5)).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	animation_player.stop()
