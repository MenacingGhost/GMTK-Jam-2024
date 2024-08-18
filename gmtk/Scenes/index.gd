extends Node2D

@onready var tile_map = $Rocks

@export var noise_height_text : NoiseTexture2D
var noise : Noise
var width : int = 200
var height : int = 500
var source_id = 3
var rock_atlas = Vector2i(9,3)
var vine_atlas = Vector2i(0,13)


func _ready():
	randomize()
	noise = noise_height_text.noise
	noise.seed = randi()
	generate_world()
	
	
func generate_world():
	for x in range(-width/2 , width/2):
		for y in range(-height , 0):
			var noise_val : float = noise.get_noise_2d(x,y)
			if noise_val >= -0.1 :
				tile_map.set_cell(Vector2(x,y) , source_id , rock_atlas)
				if noise_val >= 0.2 :
					$Vines.set_cell(Vector2(x,y) , source_id , vine_atlas)


				
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
	const BULLET = preload("res://Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $Mecha/GunPivotPoint/Gun.global_position
	new_bullet.rotation = $Mecha/GunPivotPoint.rotation
	add_child(new_bullet)
	

func spawn_energy():
	const ENERGY = preload("res://Scenes/energy.tscn")
	var new_energy = ENERGY.instantiate()
	$Mecha/Path2D/PathFollow2D.progress_ratio = randf()
	new_energy.global_position = $Mecha/Path2D/PathFollow2D.global_position
	add_child(new_energy)


func _on_timer_2_timeout():
	spawn_energy()
	$Rocks.get_data(source_id , rock_atlas , $Mecha.global_position , Vector2.ZERO)
