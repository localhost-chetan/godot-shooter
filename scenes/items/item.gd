extends Area2D


var rotation_speed := 4

const ItemType := Global.ItemType
var available_options := [ItemType.laser, ItemType.grenade, ItemType.health]
var type :int = available_options.pick_random()
var direction : Vector2
var distance := randi_range(70, 100)


func _ready():    
	if (type == ItemType.laser):
		$Sprite2D.self_modulate = Color("1ffff3")
	elif (type == ItemType.grenade):
		$Sprite2D.self_modulate = Color("e80500")
	elif (type == ItemType.health):
		$Sprite2D.self_modulate = Color("33fd09")
	else:
		$Sprite2D.self_modulate = Color("ffffff")
	
	var target_position := self.position + (direction * distance)
	var tween := self.get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_position, 0.5).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2(0.35, 0.35), 0.45).from(Vector2(0, 0))
	
	
func _process(delta: float) -> void:
	self.rotation += rotation_speed * delta


func _on_body_entered(_body: Node2D) -> void:
	if (type == ItemType.laser):
		Globals.laser_count += 5
	elif (type == ItemType.grenade):
		Globals.grenade_count += 1
	elif (type == ItemType.health):
		Globals.player_health += randi_range(10, 20)
		
	$AudioStreamPlayer2D.play()
	self.hide()
	await $AudioStreamPlayer2D.finished
	
	self.queue_free()
