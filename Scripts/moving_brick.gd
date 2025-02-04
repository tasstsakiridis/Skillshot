extends AnimatableBody2D

@export var is_barrier = false
@export var is_hitable = false
@export var hit_points:int = 1

@onready var sfxPlayer:AudioStreamPlayer = $SFXPlayer

signal brick_destroyed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage() -> void:	
	if is_hitable:
		if GameManager.soundOn():
			print("playing hit sound")
			sfxPlayer.play()
			
		hit_points -= 1;
		print("moving brick hit, hit points: " + str(hit_points))
		if hit_points <= 0:
			brick_destroyed.emit()
