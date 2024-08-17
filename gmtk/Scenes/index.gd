extends Node2D

@onready var tile_map = $TileMapLayer

func _process(delta):
	var clicked_cell = tile_map.local_to_map($Gecko.global_position)
	var data = tile_map.get_cell_tile_data(clicked_cell)
	if data:
		$Gecko.climbable = data.get_custom_data("climbable")
	else:
		$Gecko.climbable = false
		

func _on_gecko_action_pressed(target):
	if $Gecko.ShootState == true:
		spawn_bullet()
	if $Gecko.ClimbState == true:
		tounge_hook(target)
	
func spawn_bullet():
	const BULLET = preload("res://Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $Gecko/GunPivotPoint/Gun.global_position
	new_bullet.rotation = $Gecko/GunPivotPoint.rotation
	add_child(new_bullet)
	
func tounge_hook(target):
	print(target)
	$Gecko.global_position = target

func _on_gecko_shed():
	const SHED = preload("res://Scenes/shedded_skin.tscn")
	var new_shed = SHED.instantiate()
	new_shed.global_position = $Gecko.global_position
	new_shed.climbable = $Gecko.climbable
	new_shed.SPEED = $Gecko.SPEED
	new_shed.scale = $Gecko.scale
	add_child(new_shed)
