extends Node

const BUTTON_CLICK_SFX = preload("res://Assets/Sound/hit_sfx.mp3")

@onready var sfxPlayer = $SFXPlayer

func play_hit_sfx():
	sfxPlayer.stream = BUTTON_CLICK_SFX
	sfxPlayer.play()
