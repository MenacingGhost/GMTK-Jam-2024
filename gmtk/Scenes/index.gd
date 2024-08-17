extends Node2D

@onready var tile_map = $TileMapLayer

func _process(delta):
	var clicked_cell = tile_map.local_to_map($Gecko.global_position)
	var data = tile_map.get_cell_tile_data(clicked_cell)
	if data:
		$Gecko.climbable = data.get_custom_data("climbable")
	else:
		$Gecko.climbable = false
		

func _on_gecko_action_pressed():
	spawn_bullet()
	
func spawn_bullet():
	const BULLET = preload("res://Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $Gecko/GunPivotPoint/Gun.global_position
	new_bullet.rotation = $Gecko/GunPivotPoint.rotation
	add_child(new_bullet)
