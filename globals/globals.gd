class_name Global extends Node

signal stat_change()


const MAX_LASER_COUNT := 100
const MAX_GRENADE_COUNT := 30


var laser_count := MAX_LASER_COUNT:
	set(value):
		laser_count = value
		stat_change.emit()
		
var grenade_count := MAX_GRENADE_COUNT:
	set(value):
		grenade_count = value
		stat_change.emit()


var is_player_vulnerable := true
var health := 100:
	set(value):
		if (value > health):
			health = min(value, 100)
			
		elif (is_player_vulnerable):
			health = value
			is_player_vulnerable = false
			player_invulnerable_timer()		# Invulnerability frame (mercy rule)
			
		stat_change.emit()
	
 
func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	is_player_vulnerable = true
	

enum ItemType {
	laser,
	grenade,
	health
}

var player_position : Vector2
