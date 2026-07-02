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

var health := 60:
	set(value):
		health = value
		stat_change.emit()
	
 
enum ItemType {
	laser,
	grenade,
	health
}
