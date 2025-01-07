extends AnimatableBody2D

@export var hit_points:int = 1
@export var type:int = 0
@export var projectile_count:int = 0
@export var is_rotating:bool = false
@export var is_moving:bool = false
@export var move_direction:Enums.MOVE_DIRECTION = Enums.MOVE_DIRECTION.Horizontal
@export var rotation_direction:Enums.ROTATION_DIRECTION = Enums.ROTATION_DIRECTION.Clockwise
@export var speed:int = 0

signal brick_destroyed

@onready var sfxPlayer:AudioStreamPlayer = $SFXPlayer

#func _ready():
	#if is_moving:
		#var force:Vector2 = Vector2.ZERO
		#var sp = 100 if speed == 0 else speed
		#if move_direction == MOVE_DIRECTION.Horizontal:
			#force = Vector2(sp, 0)
		#else: 
			#force = Vector2(0, sp)
#
		##apply_central_force(force)
		#velocity = force * speed
		#move_and_slide()
			#
	#if is_rotating:
		#var torque = 1000
		#add_constant_torque(rotation_direction * torque)
			
		
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
