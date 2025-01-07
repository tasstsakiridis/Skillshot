extends Node

@onready var path = "user://skillshot.dat"
@onready var config_path = "user://skillshot_config.dat"

var level_info = {}

func _ready():
	load_data()
	
func save_data():
	var f = FileAccess.open(path, FileAccess.WRITE)
	level_info = {
		"level": GameManager.get_current_level()
	}
	f.store_var(level_info)
	f.close()
	
func load_data():
	if FileAccess.file_exists(path):
		var f = FileAccess.open(path, FileAccess.READ_WRITE)
		level_info = f.get_var()
		GameManager.set_current_level(level_info.level)

func save_config():
	var config = ConfigFile.new()
	config.set_value("sound", "sound", GameManager.soundState)
	config.set_value("music", "music", GameManager.musicState)
	
	var err = config.save(config_path)
	if err != OK:
		print("something went wrong")
	
func load_config():
	var config = ConfigFile.new()
	var default_options = {
		"music" : true,
		"sound" : true
	}
	var err = config.load(config_path)
	if err == OK:
		default_options.sound = config.get_value("sound", "sound", true)
		default_options.music = config.get_value("music", "music", true)
	
	return default_options
