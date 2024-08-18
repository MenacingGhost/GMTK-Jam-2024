extends TileMapLayer

var astargrid = AStarGrid2D.new()
const main_source = 0
const path_taken_atlas = Vector2i(3,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()
	show_path()

func setup_grid():
	astargrid.region = Rect2i(0,0,7,6)
	astargrid.cell_size = Vector2i(16,16)
	astargrid.update()
	
func show_path():
	var path_taken = astargrid.get_id_path(Vector2i(0,0) , Vector2i(6,3))
	for cell in path_taken:
		set_cell(cell ,main_source , path_taken_atlas)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
