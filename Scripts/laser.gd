extends AnimatableBody2D

@export var pulse:bool = false
@export var pulse_time:float = 1.0
@export var wait_time:float = 1.0

@onready var collisionShape = $CollisionShape2D

var timer_is_waiting:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$waitTimer.wait_time = wait_time
	
	if pulse:
		$Timer.wait_time = pulse_time
		$Timer.start(pulse_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("fade_laser")
	

func disable_collision():	
	collisionShape.disabled = true
	$waitTimer.start(pulse_time)	
	
func enable_collision():
	$Timer.start(pulse_time)	
	
func _on_wait_timer_timeout() -> void:
	collisionShape.disabled = false
	$AnimationPlayer.play("fade_in_laser")
