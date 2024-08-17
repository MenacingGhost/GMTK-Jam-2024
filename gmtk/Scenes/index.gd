extends Node2D

@onready var tile_map = $TileMapLayer

func _process(delta):
	var clicked_cell = tile_map.local_to_map($Gecko.global_position)
	var data = tile_map.get_cell_tile_data(clicked_cell)
	if data:
		$Gecko.climbable = data.get_custom_data("climbable")
	else:
		$Gecko.climbable = false
		
		
