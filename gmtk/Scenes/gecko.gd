extends CharacterBody2D


const SPEED = 100.0

var climbable = false

func _physics_process(delta):
	if climbable == true:
		var direction = Input.get_vector("left", "right" , "up" , "down")
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		velocity += get_gravity() * delta

	move_and_slide()
	
