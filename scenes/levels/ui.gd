extends CanvasLayer

@onready var laser_label: Label = %LaserLabel
@onready var laser_texture: TextureRect = %LaserTexture

@onready var grenade_label: Label = %GrenadeLabel
@onready var grenade_texture: TextureRect = %GrenadeTexture


const green := Color("27ff70")
const orange := Color("ff9b05")
const red := Color("db3916")


func _ready():
	update_laser_text()
	update_grenade_text()
	

func update_color(amount:int, half_amount:int, label:Label, icon:TextureRect) -> void:
	if (amount <= 0):  
		label.modulate = red
		icon.modulate = red
	elif (amount <= half_amount):    
		label.modulate = orange
		icon.modulate = orange
	else:
		label.modulate = green
		icon.modulate = green


func get_half_amount(amount:int) -> int:
	var half_amount := int(floor(amount / 2.0))
	return half_amount


func update_laser_text(): 
	var laser_count := Globals.laser_count
	laser_label.text = str(laser_count)
	update_color(laser_count, get_half_amount(Globals.MAX_LASER_COUNT), laser_label, laser_texture)
  

func update_grenade_text():
	var grenade_count := Globals.grenade_count
	grenade_label.text = str(grenade_count)
	update_color(grenade_count, get_half_amount(Globals.MAX_GRENADE_COUNT), grenade_label, grenade_texture)
