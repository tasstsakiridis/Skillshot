extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var drag = ProjectSettings.get_setting("physics/2d/default_linear_damp")

func _physics_process(delta):
	pass
	#velocity.y += gravity * delta
	#velocity = velocity * clampf(1.0 - drag * delta, 0, 1)
	#
	#var collision = move_and_collide(velocity * delta)
	#if not collision:
		#return
		#
	#velocity = velocity.bounce(collision.get_normal())
	#
	#if collision.get_collider().has_method("take_damage"):
		#collision.get_collider().take_damage()
