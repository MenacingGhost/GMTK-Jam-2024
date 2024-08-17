extends Area2D

func _physics_process(delta) :
	const SPEED = 500.0
	const RANGE = 1200
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
