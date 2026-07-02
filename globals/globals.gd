class_name Global extends Node

const MAX_LASER_COUNT := 100
const MAX_GRENADE_COUNT := 30

var laser_count := MAX_LASER_COUNT
var grenade_count := MAX_GRENADE_COUNT
 
enum ItemType {
	laser,
	grenade,
	health
}
