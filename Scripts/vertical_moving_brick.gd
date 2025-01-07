extends Path2D

@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0
@export var hit_points:int = 1
@export var is_hitable:bool = false
@export var brick_rotation = 0.0
@export var is_barrier:bool = true

@onready var path = $PathFollow2D
@onready var animationPlayer = $AnimationPlayer
@onready var remoteTransform = $PathFollow2D/RemoteTransform2D
@onready var brickSprite = $Brick/BrickSprite

const BARRIER_TEXTURE = preload("res://assets/Sprites/Barrier.png")

signal brick_destroyed

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_barrier && BARRIER_TEXTURE != null:
		brickSprite.texture = BARRIER_TEXTURE
	
	if not loop:
		animationPlayer.speed_scale = speed_scale
		animationPlayer.play("vertical_moving_platform")
		set_process(false)
	
	if brick_rotation > 0:
		remoteTransform.rotation = deg_to_rad(brick_rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path.progress += speed
	
func take_damage() -> void:
	if is_hitable:
		hit_points -= 1;
		if hit_points <= 0:
			queue_free()
			brick_destroyed.emit()
