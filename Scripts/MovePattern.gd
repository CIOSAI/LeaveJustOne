extends Node2D
class_name MovePattern

var dels:Array

func get_all_pieces_pos()->Array:
	var o:Array = []
	for i in Globals.gm.all_pieces():
		o.append(i.pos)
	return o

func algo(pos:Vector2)->Array:
	print("algo not implemented")
	return []

func can_move_to(pos:Vector2):
	var options_in_bound:Array = []
	dels = []
	
	if get_parent().piece_index != LS.DAGGER:
		for i in Globals.gm.all_pieces():
			if i.piece_index == LS.BOULDER:
				dels.append(i.pos)

	for i in algo(pos):
		if Globals.gm.on_board(i):
			if !(i in dels):
				options_in_bound.append(i)

	return options_in_bound
