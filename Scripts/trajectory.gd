extends Line2D

@export var EXPLOSION_FORCE : float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	
func _draw():
##	update_trajectory()
	pass
	

##func update_trajectory() -> void:
##	var line_start := global_position
##	var line_end: Vector2
##	var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
##	var drag:float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
##	var timestep := 0.02
##	var pos: Vector2 = Vector2.ZERO
##			
