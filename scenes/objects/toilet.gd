extends ItemContainer

var max_available_items := 1


func hit() -> void:
	if (OS.is_debug_build()):
		print("max_available_items ", max_available_items)
	
	if (max_available_items >= 1):
		print("Toilet")
		
		$LidSprite.hide()
		var pos := ($SpawnPositions/Marker2D as Marker2D).global_position
		open.emit(pos, current_direction)
		
		max_available_items -= 1
