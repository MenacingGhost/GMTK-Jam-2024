extends CharacterBody2D


var SPEED = 100.0

signal actionPressed

var ClimbState = true
var ShootState = false
var climbable = false

func _process(delta):
	$GunPivotPoint.look_at(get_global_mouse_position())
	
	if ShootState == true:
		if Input.is_action_just_pressed("action"):
			emit_signal("actionPressed")
		
	if Input.is_action_just_pressed("switch_mode"):
		if ClimbState == true:
			ClimbState = false
			ShootState = true
			SPEED = 0
			$GunPivotPoint/Gun.show()
			
		elif ClimbState == false:
			ClimbState = true
			ShootState = false
			SPEED = 100.0
			$GunPivotPoint/Gun.hide()
	
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
	
