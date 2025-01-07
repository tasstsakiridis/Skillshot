extends Control

@export var soundOnTexture:Texture2D
@export var soundOffTexture:Texture2D
@export var musicOnTexture:Texture2D
@export var musicOffTexture:Texture2D

@onready var soundToggle = $OptionsMenu/VBoxContainer/MenuOptions/SoundToggle
@onready var musicToggle = $OptionsMenu/VBoxContainer/MenuOptions/MusicToggle

@onready var animationPlayer = $AnimationPlayer

@onready var sfxPlayer = $SFXPlayer
@onready var musicPlayer = $MusicPlayer

var soundOn = true
var musicOn = true

func _onready():
	var config = GameDataManager.load_config()
	GameDataManager.load_data()
	
	soundOn = config.sound
	musicOn = config.music
	
	set_music_texture()
	set_sound_texture()
	
func _on_sound_toggle_pressed():
	soundOn = !soundOn	
	set_sound_texture()
	GameManager.setSoundState(soundOn)
	

func _on_music_toggle_pressed():
	musicOn = !musicOn
	set_music_texture()
	GameManager.setMusicState(musicOn)

func _on_back_button_pressed():
	if soundOn:
		sfxPlayer.play()
		
	animationPlayer.play("settings_slide_out")

func _on_options_button_pressed():
	if soundOn:
		sfxPlayer.play()

	animationPlayer.play("main_slide_out")

func _on_new_game_button_pressed():	
	if soundOn:
		sfxPlayer.play()

	GameManager.start_over()
	get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")

func set_sound_texture():
	if soundOn:
		soundToggle.texture_normal = soundOnTexture
		musicPlayer.play()
	else:
		soundToggle.texture_normal = soundOffTexture
		musicPlayer.stop()
	
func set_music_texture():
	if musicOn:
		musicToggle.texture_normal = musicOnTexture
		musicPlayer.play()
	else:
		musicToggle.texture_normal = musicOffTexture
		musicPlayer.stop()
