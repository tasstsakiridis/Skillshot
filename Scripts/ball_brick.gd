extends Path2D

@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0
@export var hit_points:int = 1
@export var ball_count:int = 1
@export var is_moving:bool = false
@export var move_direction := Enums.MOVE_DIRECTION.Horizontal
@export var is_rotating:bool = false
@export var rotate_direction:Enums.ROTATION_DIRECTION = Enums.ROTATION_DIRECTION.Clockwise

@onready var brick = $brick
@onready var projectile1 = $brick/Projectile
@onready var projectile2 = $brick/Projectile2
@onready var projectile3 = $brick/Projectile3
@onready var animationPlayer = $AnimationPlayer

signal brick_destroyed

# Called when the node enters the scene tree for the first time.
func _ready():
	print(str(projectile1.position))
	print(str(brick.global_position))
	#if ball_count >= 1:
		#projectile1.visible = true
	#if ball_count >= 2:
		#projectile2.visible = true
	#if ball_count == 3:
		#projectile3.visible = true
		
	if is_moving and not loop:
		animationPlayer.play("move_ball_brick")
		animationPlayer.speed_scale = speed_scale
		set_process(false)
	
	if is_rotating:
		animationPlayer.play("rotate_ball_brick")
		animationPlayer.speed_scale = speed_scale
		set_process(false)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_damage() -> void:
	hit_points -= 1;
	brick_destroyed.emit()
	#if hit_points <= 0:
		## release balls
		#if ball_count >= 1:
			#projectile1.disable_mode = DISABLE_MODE_KEEP_ACTIVE
		#if ball_count >= 2:
			#projectile2.disable_mode = DISABLE_MODE_KEEP_ACTIVE
		#if ball_count >= 3:
			#projectile3.disable_mode = DISABLE_MODE_KEEP_ACTIVE
		
