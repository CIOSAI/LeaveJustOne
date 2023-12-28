extends Node

onready var gm:TileMap = Globals.gm
var hand:Node2D
var fx_win:AudioStreamPlayer

export(NodePath) var hand_path
export(NodePath) var fx_win_path

var all_actions:Array = []

var alive_pieces:int = 0
var won:bool = false

var have_removed_this_frame:bool = false

signal won(pos)
signal next_level

func _ready():
	hand = get_node(hand_path)
	fx_win = get_node(fx_win_path)

func start_level(n:LS.State):
	make_level(n)
	all_actions.append([alive_pieces, create_level_state()])

func make_level(n:LS.State):
	clear_board()
	clear_hand()
	
	for i in n.board:
		spawn_at(LS.piece_scenes[i.piece], i.pos)
	for i in n.hand:
		hand.add_piece(i)
		if i != LS.BOULDER: alive_pieces+=1
	
	hand.connect("piece_add_to_board", self, "on_piece_add_to_board")
	gm.connect_focus_signals()
	hand.connect_focus_signals()

func create_level_state()->LS.State:
	var board:Array = []
	for i in gm.all_pieces():
		board.append(sp(i.piece_index, i.pos))
	var onhand:Array = []
	for i in hand.all_pieces():
		onhand.append(i.piece_index)
	
	return LS.State.new(board, onhand)

func listen_for_piece_death(n:Piece):
	n.connect("died", self, "on_piece_amount_change", [n])

func spawn_at(scene:PackedScene, v:Vector2=Vector2.ZERO):
	var n = scene.instance()
	n.pos = v
	if n.piece_index != LS.BOULDER: alive_pieces+=1
	listen_for_piece_death(n)
	gm.add_child(n)

func on_piece_add_to_board(p:Piece):
	listen_for_piece_death(p)
	if have_removed_this_frame: all_actions.pop_back()
	all_actions.append([alive_pieces, create_level_state()])
	have_removed_this_frame = false

func on_piece_amount_change(moved_piece:Piece):
	alive_pieces -= 1
	if alive_pieces==1:
		if !Globals.editting:
			win(moved_piece.pos)
	else:
		have_removed_this_frame = true
		all_actions.append([alive_pieces, create_level_state()])

func _input(event):
	if event.is_action_pressed("Retry")&&(!won):
		retry()
	if event.is_action_pressed("Previous")&&(!won):
		last_step()

func retry():
	reload()
	start_level(get_parent().level_manager.get_level())

func last_step():
	if all_actions.size()>1: all_actions.pop_back()
	alive_pieces = all_actions.back()[0]
	make_level(all_actions.back()[1])

func reload():
	alive_pieces = 0
	all_actions = []
	won = false

func clear_board():
	for i in gm.all_pieces():
		i.disconnect("died", self, "on_piece_amount_change")
		i.death()

func clear_hand():
	for i in hand.get_children():
		i.queue_free()

func sp(a:int, b:Vector2)->LS.Spot: return LS.Spot.new(a, b)

func win(finishing_pos:Vector2):
	fx_win.play()
	won = true
	
	emit_signal("won", Globals.gm.grid_to_world(finishing_pos))
	
	$"Button".mouse_filter = Control.MOUSE_FILTER_STOP
	yield($"Button", "pressed")
	$"Button".mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	reload()
	
	emit_signal("next_level")
