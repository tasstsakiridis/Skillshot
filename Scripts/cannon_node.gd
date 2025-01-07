extends Node2D

@onready var cannon = $".."

func _process(_delta):
	if !cannon.cannon_fired:
		var to_mouse = global_position - get_global_mouse_position()
		var offset = -PI / 2
		var rotation_to_mouse = to_mouse.angle() + offset
		rotation = lerp_angle(rotation, rotation_to_mouse, 0.25)
			
		queue_redraw()
