extends CharacterBody2D

@export var EXPLOSION_FORCE : float = 1250.0

@onready var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var drag:float = ProjectSettings.get_setting("physics/2d/default_linear_damp")

@onready var PROJECTILE : CharacterBody2D = $Projectile
@onready var TEST_PROJECTILE : CharacterBody2D = $TestProjectile
@onready var TRAJECTORY : Line2D = $Trajectory2D
@onready var LAUNCH_POINT : Node2D = $LaunchPoint

var cannon_fired: bool = false
var show_trajectory: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if !cannon_fired:
		#var to_mouse = global_position - get_global_mouse_position()
		#var offset = -PI / 2
		#var rotation_to_mouse = to_mouse.angle() + offset
		#$cannon_img.rotation = lerp_angle(rotation, rotation_to_mouse, 0.25)
			#
		#queue_redraw()
	pass
	
func _physics_process(delta):
	if show_trajectory:
		update_trajectory()
	
func _draw() -> void:
	if show_trajectory:
		update_trajectory()
	
func _input(event):	
	if cannon_fired:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			TEST_PROJECTILE.get_node("CollisionShape2D").disabled = false
			show_trajectory = true;
			
		elif event.button_index == 1 and not event.is_pressed():
			show_trajectory = false
	elif event is InputEventMouseMotion:
		#print("Mouse click at " + str(event.position))
		pass
	
func _unhandled_input(event):
	if event.is_action_released("fire") and !cannon_fired:
		TRAJECTORY.clear_points()
		do_attack()
		
func do_attack() -> void:
	GameManager.gameState = Enums.GAME_STATE.Fired
	
	TEST_PROJECTILE.get_node("CollisionShape2D").disabled = true
	TEST_PROJECTILE.visible = false
	
	PROJECTILE.visible = true
	PROJECTILE.velocity = EXPLOSION_FORCE * get_forward_direction()
	
	cannon_fired = true
	
func get_forward_direction() -> Vector2:
	return LAUNCH_POINT.global_position.direction_to(get_global_mouse_position())
	
func update_trajectory() -> void:
	var v = EXPLOSION_FORCE * get_forward_direction()
	var timestep := 0.02
	
	TRAJECTORY.clear_points()
	TEST_PROJECTILE.global_position = LAUNCH_POINT.global_position
	
	var pos : Vector2 = Vector2.ZERO
	
	for i:int in 50:
		TRAJECTORY.add_point(pos)
		v.y += gravity * timestep
		v = v * clampf(1.0 - drag * timestep, 0, 1)
				
		var collision = TEST_PROJECTILE.move_and_collide(v * timestep)
		if collision:
			v = v.bounce(collision.get_normal())
												
		pos += v * timestep
		TEST_PROJECTILE.position = pos;		
	
