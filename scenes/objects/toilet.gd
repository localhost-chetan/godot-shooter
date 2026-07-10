extends ItemContainer


var max_available_items := 1


func _ready():
	if (OS.is_debug_build()):
		print("max_available_items ", max_available_items)
		

func hit() -> void:
	if (max_available_items >= 1):
		$LidSprite.hide()
		$AudioStreamPlayer2D.play()
		var pos := ($SpawnPositions/Marker2D as Marker2D).global_position
		open.emit(pos, current_direction)
		
		max_available_items -= 1
