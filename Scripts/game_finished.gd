extends Control

func _on_start_over_button_pressed():
	GameManager.start_over()
	get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")
