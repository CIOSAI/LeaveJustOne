extends Node2D

const piece_on_hand_script:Script = preload("res://Scripts/LevelMakerPieceOnHand.gd")

signal piece_add_to_board(p)

func add_piece(ind:int):
	var n = LS.piece_scenes[ind].instance()
	n.script = piece_on_hand_script
	n.piece_index = ind
	n.position = Vector2.ZERO
	n.connect("setted", self, "on_piece_setted", [n])
	add_child(n)
	return n

func on_piece_setted(p:Piece):
	p.queue_free()
	var n = LS.piece_scenes[p.piece_index].instance()
	n.global_position = p.global_position-Globals.gm.position
	n.pos = p.pos
	Globals.gm.add_child(n)
	emit_signal("piece_add_to_board", n)

func all_pieces()->Array:
	var o:Array = []
	for i in get_children():
		if i is Piece:
			if !i.dead: o.append(i)
	return o

func connect_focus_signals():
	for i in all_pieces():
		for j in all_pieces():
			i.connect("hand_mouse_entered", j, "hand_occupied")
