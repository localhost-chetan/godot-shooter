extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func change_scene(target: String):
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("fade_to_black")
