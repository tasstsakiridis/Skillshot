extends CanvasLayer

@onready var game_won_message:TextureRect = $MainMenu/VBoxContainer/MenuOptions/GameWonMessage
@onready var game_lost_message:TextureRect = $MainMenu/VBoxContainer/MenuOptions/GameLostMessage
@onready var continue_button:TextureButton = $MainMenu/VBoxContainer/MenuOptions/Continue
@onready var tryagain_button:TextureButton = $MainMenu/VBoxContainer/MenuOptions/TryAgain

@onready var sfxPlayer:AudioStreamPlayer = $SFXPlayer
@onready var musicPlayer:AudioStreamPlayer = $MusicPlayer

func _ready():
	get_tree().paused = false
	if GameManager.gameState == Enums.GAME_STATE.Won:
		game_lost_message.visible = false 
		tryagain_button.visible = false
		game_won_message.visible = true
		continue_button.visible = true
	else:
		game_won_message.visible = false
		continue_button.visible = false
		game_lost_message.visible = true
		tryagain_button.visible = true
		

func _on_continue_pressed():
	if GameManager.soundOn():
		sfxPlayer.play()
		
	GameManager.get_next_level()
	get_tree().change_scene_to_file("res://Scenes/levels/level_"+str(GameManager.level)+".tscn")

func _on_try_again_pressed():
	if GameManager.soundOn():
		sfxPlayer.play()
	
	get_tree().change_scene_to_file("res://Scenes/levels/level_"+str(GameManager.level)+".tscn")

func _on_back_pressed():
	if GameManager.soundOn():
		sfxPlayer.play()

	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
