extends Node2D

@onready var tile_map = $Rocks

@export var noise_height_text : NoiseTexture2D
var noise : Noise
var width : int = 400
var height : int = 400
var source_id = 3
var rock_atlas = Vector2i(9,3)

func _ready():
	noise = noise_height_text.noise
	generate_world()
	
func generate_world():
	for x in range(-width/2 , width/2):
		for y in range(-height , height):
			var noise_val : float = noise.get_noise_2d(x,y)
			if noise_val >= 0.0 :
				tile_map.set_cell(Vector2(x,y) , source_id , rock_atlas)
			elif noise_val < 0.0 :
				pass
				
func _process(delta):
	var clicked_cell = tile_map.local_to_map($Mecha.global_position)
	var data = tile_map.get_cell_tile_data(clicked_cell)
	if data:
		$Mecha.climbable = data.get_custom_data("climbable")
	else:
		$Mecha.climbable = false
		

func _on_mecha_action_pressed(target):
	if $Mecha.ShootState == true:
		spawn_bullet()
	
func spawn_bullet():
	print("bullet")
	const BULLET = preload("res://Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $Mecha/GunPivotPoint/Gun.global_position
	new_bullet.rotation = $Mecha/GunPivotPoint.rotation
	add_child(new_bullet)
	

func _on_mecha_shed():
	print("shed")
	const SHED = preload("res://Scenes/shedded_skin.tscn")
	var new_shed = SHED.instantiate()
	new_shed.global_position = $Mecha.global_position
	new_shed.climbable = $Mecha.climbable
	new_shed.SPEED = $Mecha.SPEED
	new_shed.scale = $Mecha.scale
	add_child(new_shed)
