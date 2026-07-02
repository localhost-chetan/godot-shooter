extends Area2D


var rotation_speed := 4

const ItemType := Global.ItemType
var available_options := [ItemType.laser, ItemType.grenade, ItemType.health]
var type :int = available_options.pick_random()


func _ready():    
	if (type == ItemType.laser):
		$Sprite2D.self_modulate = Color("1ffff3")
	elif (type == ItemType.grenade):
		$Sprite2D.self_modulate = Color("e80500")
	elif (type == ItemType.health):
		$Sprite2D.self_modulate = Color("33fd09")
	else:
		$Sprite2D.self_modulate = Color("ffffff")
		
	

func _process(delta: float) -> void:
	self.rotation += rotation_speed * delta


func _on_body_entered(_body: Node2D) -> void:
	if (type == ItemType.laser):
		Globals.laser_count += 5
	elif (type == ItemType.grenade):
		Globals.grenade_count += 1
	elif (type == ItemType.health):
		Globals.health += 10
		
	self.queue_free()
