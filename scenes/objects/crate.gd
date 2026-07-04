extends ItemContainer

var max_available_items := randi_range(3, 10)

func hit():
	if (OS.is_debug_build()):
		print("max_available_items ", max_available_items)
	
	if (max_available_items >= 1):
		$LidSprite.hide()
		var pos := ($SpawnPositions.get_children().pick_random() as Marker2D).global_position
		open.emit(pos, current_direction)
		
		max_available_items -= 1
