extends TileMap

var dimensions:int = 4
enum {DEFAULT=0, VACANT=3, TARGET=2, AVAILABLE=1}

func _ready():
	Globals.gm = self

func get_mouse_position():
	return get_local_mouse_position()

func world_to_grid(v:Vector2)->Vector2:
	return world_to_map(v)

func grid_to_world(v:Vector2)->Vector2:
	return map_to_world(v)+cell_size/2

func all_pieces()->Array:
	var o:Array = []
	for i in get_children():
		if i is Piece:
			if !i.dead: o.append(i)
	return o

func all_pieces_pos()->Array:
	var o:Array = []
	for i in all_pieces():
		o.append(i.pos)
	return o

func piece_at(v:Vector2)->Piece:
	for i in all_pieces():
		if i.pos == v:
			return i
	return null

func clear_grid_display():
	for x in dimensions:
		for y in dimensions:
			set_cell(x, y, DEFAULT)

func grid_display_vacant(can:Array, allow:Array, target:Vector2=Vector2(-1, -1)):
	for i in can:
		if on_board(i):
			if allow.empty() || i in allow:
				if target.is_equal_approx(i):
					set_cellv(i, TARGET)
				else:
					set_cellv(i, AVAILABLE)
			else:
				set_cellv(i, VACANT)

func on_board(v:Vector2)->bool:
	return (v.x>=0 && v.x<dimensions)&&(v.y>=0 && v.y<dimensions)

func connect_focus_signals():
	for i in all_pieces():
		for j in all_pieces():
			if i==j: continue
			i.controller.connect("picked_up", j.controller, "hand_occupied")
			i.controller.connect("set_down", j.controller, "hand_free")
