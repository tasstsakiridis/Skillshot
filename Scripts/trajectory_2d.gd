extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_trajectory(dir: Vector2, speed: float, gravity: float, delta: float) -> void:
	var max_points = 300
	clear_points()
	
	var pos:Vector2 = Vector2.ZERO
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		
		var collision = $CollisionTest.move_and_collide(vel * delta, false, true, true)
		if collision:
			print("collision: " + collision.name)
			vel = vel.bounce(collision.normal) * 0.6
			
		pos += vel * delta
		$CollisionTest.position = pos
		
