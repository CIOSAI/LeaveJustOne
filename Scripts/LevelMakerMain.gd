extends Control

onready var game_level = $"GameLevel"
onready var level_manager = $"LevelManager"
onready var hand = $"Hand"

onready var add_to_hand = $"VBoxContainerR/AddToHand"

func _ready():
	Globals.editting = true
	for i in LS.piece_scenes.size():
		hand.add_piece(i)
		add_to_hand.add_icon_item(
			LS.piece_scenes[i].instance().texture, "", i)
	hand.connect("piece_add_to_board", self, "on_piece_add_to_board")
	hand.connect_focus_signals()
	
	for i in LevelSave.all_levels.size():
		$"VBoxContainer/OptionButton".add_item(str(i), i)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/TempMenu.tscn")

func get_piece_held():
	for i in hand.all_pieces():
		if i.controller.holding:
			return i
	return false

func on_piece_add_to_board(p:Piece):
	p.controller.controllable = false
	hand.add_piece(p.piece_index)

func get_cursor(): return $"VBoxContainer/OptionButton".selected

func _on_Save_pressed():
	LevelSave.save_levels(game_level.create_level_state(), 
		get_cursor())
	LevelSave.load_levels()

func _on_Load_pressed():
	LevelSave.load_levels()
	game_level.make_level(LevelSave.all_levels[
		get_cursor()])

func _on_New_pressed():
	LevelSave.save_levels(LS.State.new([], []), 
		LevelSave.all_levels.size())
	LevelSave.load_levels()
	get_tree().reload_current_scene()

func _on_AddPieceToHand_pressed():
	$"GameHand".add_piece(add_to_hand.get_item_id(add_to_hand.selected))
	$"GameHand".connect_focus_signals()
