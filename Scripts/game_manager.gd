extends Node

const MAX_LEVELS:int = 100

var soundState:bool = true
var musicState:bool = true
var gameState:Enums.GAME_STATE = Enums.GAME_STATE.None
var level:int = 1

signal level_changed

func set_game_state(newState) -> void:
	gameState = newState
	print("new game state: " + str(newState))
	match gameState:
		Enums.GAME_STATE.Loading:
			pass
		Enums.GAME_STATE.Playing:
			pass
		Enums.GAME_STATE.Won:
			get_tree().paused = true
			get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
			
		Enums.GAME_STATE.Lost:
			get_tree().paused = true
			get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
			
		Enums.GAME_STATE.Paused:
			pass
		
func setSoundState(ss):
	soundState = ss
	GameDataManager.save_config()
	
func setMusicState(ms):
	musicState = ms
	GameDataManager.save_config()
	
func get_current_level():
	return level
	
func set_current_level(lvl):
	level = lvl
	
func get_next_level():
	level = level + 1
	print("[gamemanager] level: " + str(level))
	emit_signal("level_changed", level)
	GameDataManager.save_data()
	if level > MAX_LEVELS:
		get_tree().change_scene_to_file("res://Scenes/game_finished.tscn")

func start_over():
	print("game manager start over")
	level = 1
	emit_signal("level_changed", level)

func soundOn():
	return soundState
	
func musicOn():
	return musicState
