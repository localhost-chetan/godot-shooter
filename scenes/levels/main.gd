extends Node



func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	print("Body exited")
