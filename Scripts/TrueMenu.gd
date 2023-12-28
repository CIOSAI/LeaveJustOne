extends Control

const intro_level_dir = "res://Special Levels/Menu.tres"

onready var tw = $"Tween"
onready var game_level = $"GameLevel"
onready var level_manager = $"LevelManager"
onready var hand = $"Hand"

func _ready():
	Globals.editting = false
	
	var level = load(intro_level_dir)
	game_level.start_level(
		LevelSave.unfolded_to_state(
			[level.ind, level.pos, level.hand]
		)
	)
	
	for i in Globals.gm.all_pieces():
		i.connect("setted", self, "piece_set_down", [i])
	
	update_level_text()

func piece_set_down(p:Piece):
	var to_scene:String
	match p.pos:
		Vector2(1, 0):
			to_scene = "res://Scenes/Arranger.tscn"
		Vector2(2, 1):
			to_scene = "res://Scenes/LevelMaker.tscn"
		Vector2(1, 2):
			to_scene = "res://Scenes/Main.tscn"
		Vector2(0, 1):
			get_tree().quit()
	get_tree().change_scene(to_scene)

func update_level_text():
	var rand_text = [
		"ah i love capybaras", 
		"the gear icon is settings",
		"<3",
		"this game is made with godot",
		"hewwo",
		"my code is so bad tbh",
		"bprbprpbrpppbpr",
		"did you play the cat game?",
		"i made this font myself",
		"heh",
		"i know what you did",
	]
	randomize()
	$"Label".text = rand_text[randi()%rand_text.size()].to_upper()
