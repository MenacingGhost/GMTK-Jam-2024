extends CharacterBody2D


var SPEED = 100.0
var HP = 3
var STAMINA = 100

signal actionPressed
signal shed

var ClimbState = true
var ShootState = false
var climbable = false

func _process(delta):
	$GunPivotPoint.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("action"):
		emit_signal("actionPressed" , get_global_mouse_position())
		print("click")
			
		
	if Input.is_action_just_pressed("switch_mode"):
		print("swirch")
		if ClimbState == true:
			ClimbState = false
			ShootState = true
			SPEED = 0
			$GunPivotPoint/Gun.show()
			$Timer.stop()
			
		elif ClimbState == false:
			ClimbState = true
			ShootState = false
			SPEED = 100.0
			$GunPivotPoint/Gun.hide()
			$Timer.start()
	
func _physics_process(delta):
	
	if climbable == true and STAMINA > 0:
		var direction = Input.get_vector("left", "right" , "up" , "down")
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
	if climbable == false or STAMINA <= 0:
		velocity += get_gravity() * delta

	move_and_slide()
	


func _on_timer_timeout():
	STAMINA -= 1
	print(STAMINA)


func _on_area_2d_body_entered(body):
	STAMINA += 5
	print("+STAMNIA")
