extends AnimatableBody2D

@export var hit_points:int = 1
@export var type:int = 0
@export var projectile_count:int = 0
@export var is_rotating:bool = false
@export var is_moving:bool = false
@export var move_direction:Enums.MOVE_DIRECTION = Enums.MOVE_DIRECTION.Horizontal
@export var rotation_direction:Enums.ROTATION_DIRECTION = Enums.ROTATION_DIRECTION.Clockwise
@export var speed:int = 0
@export var pulse:bool = false
@export var pulse_time:float = 1.0
@export var wait_time:float = 1.0

signal brick_destroyed

@onready var sfxPlayer:AudioStreamPlayer = $SFXPlayer

func _ready():
	if $waitTime != null:
		$waitTimer.wait_time = wait_time
		
		if pulse:
			$Timer.wait_time = pulse_time
			$Timer.start(pulse_time)
		
func take_damage() -> void:
	if GameManager.soundOn():
		print("playing hit sound")
		sfxPlayer.play()
		
	hit_points -= 1;
	if hit_points <= 0:
		brick_destroyed.emit()
		queue_free()
		
func _on_body_entered(body):
	pass

func disable_collision():	
	$CollisionShape2D.disabled = true
	$WaitTimer.start(pulse_time)	
	
func enable_collision():
	$Timer.start(pulse_time)	


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("pulse_out")

func _on_wait_timer_timeout() -> void:
	$CollisionShape2D.disabled = false
	$AnimationPlayer.play("pulse")
