extends TextureRect

@onready var level_label = $MarginContainer/HBoxContainer/level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = str(GameManager.get_current_level())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_manager_level_changed(levelNumber: Variant) -> void:
	print("level changed: " + str(levelNumber))
	level_label.text = str(levelNumber)


func _on_game_window_level_changed(level_number: int) -> void:
	level_label.text = str(level_number)
