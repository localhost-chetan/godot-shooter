extends Area2D


var rotation_speed := 4

const ItemType := Global.ItemType
var available_options := [ItemType.laser, ItemType.grenade, ItemType.health]
var type = available_options.pick_random()


func _ready():
	print("type ", type)
	
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


func _on_body_entered(body: Node2D) -> void:
	if ("add_item" in body):
		body.add_item(type)	
		self.queue_free()
