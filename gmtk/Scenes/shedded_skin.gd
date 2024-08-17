extends CharacterBody2D

var climbable = false
var SPEED = 100.0

func _physics_process(delta):
	if climbable == true:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		velocity += get_gravity() * delta

	move_and_slide()

	move_and_slide()
	
