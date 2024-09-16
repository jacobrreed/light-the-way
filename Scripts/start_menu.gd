extends Control

func start_game() -> void:
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_game()
