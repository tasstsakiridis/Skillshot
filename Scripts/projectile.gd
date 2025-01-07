extends CharacterBody2D

@onready var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var drag:float = ProjectSettings.get_setting("physics/2d/default_linear_damp")

@export var is_trajectory_projectile:bool = false
	
func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = velocity * clampf(1.0 - drag * delta, 0, 1)
	
	var collision = move_and_collide(velocity * delta)
	if not collision:
		return
		
	var normal = collision.get_normal()
	#print("projectile collision: " + str(collision) + ", normal: " + str(normal) + ", velocity: " + str(velocity.normalized()))
	if normal.dot(velocity.normalized()) <= 0.0:
		velocity = velocity.bounce(normal) * 0.8
		#print("projectile bounc velocity: " + str(velocity))
	
	if collision.get_collider().has_method("take_damage"):
		collision.get_collider().take_damage()
		
	if collision.get_collider().has_meta("is_bottom_wall") && !is_trajectory_projectile:
		velocity = Vector2.ZERO
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(0, -20), 0.5)
		tween.connect("finished", on_reset_position_finished)
		

func on_reset_position_finished():
	GameManager.set_game_state(Enums.GAME_STATE.Lost)
	
